%Module popplerqt4 0

%Import QtCore/QtCoremod.sip
%Import QtGui/QtGuimod.sip
%Import QtXml/QtXmlmod.sip

%Timeline {
    POPPLER_V0_12_0
    POPPLER_V0_12_1
    POPPLER_V0_14_0
    POPPLER_V0_16_0
    POPPLER_V0_18_0
    POPPLER_V0_20_0
    POPPLER_V0_22_0
    POPPLER_V0_24_0
}

%Include types.sip
%Include poppler-link.sip
%Include poppler-form.sip
%Include poppler-annotation.sip
%Include poppler-convert.sip
%Include poppler-page-transition.sip

%ModuleHeaderCode
#include <qt4/poppler-qt4.h>
%End

/*
 * Bindings for Poppler-Qt4 to Python
 * Maintained by Wilbert Berendsen <wbsoft@xs4all.nl>
 */

namespace Poppler {


class Document {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
%If(POPPLER_V0_22_0 -)
    enum FormType {
        NoForm,
        AcroForm,
        XfaForm,
    };
%End
    enum PageMode {
        UseNone,
        UseOutlines,
        UseThumbs,
        FullScreen,
        UseOC,
        UseAttach,
    };
    enum PageLayout {
        NoLayout,
        SinglePage,
        OneColumn,
        TwoColumnLeft,
        TwoColumnRight,
        TwoPageLeft,
        TwoPageRight,
    };
    enum RenderBackend {
        SplashBackend,
        ArthurBackend,
    };
    enum RenderHint {
        Antialiasing = 0x00000001,
        TextAntialiasing = 0x00000002,
%If(POPPLER_V0_12_1 -)
        TextHinting = 0x00000004,
%End
%If(POPPLER_V0_18_0 -)
        TextSlightHinting = 0x00000008,
%End
%If(POPPLER_V0_22_0 -)
        OverprintPreview = 0x00000010,
%End
%If(POPPLER_V0_24_0 -)
        ThinLineSolid = 0x00000020,
        ThinLineShape = 0x00000040,
%End
    };
    typedef QFlags<Poppler::Document::RenderHint> RenderHints;
    
    void setColorDisplayProfile(void *outputProfileA);
    void setColorDisplayProfileName(const QString &name);
    void* colorRgbProfile() const;
    void* colorDisplayProfile() const;
    static Poppler::Document *load(const QString & filePath,
                            const QByteArray &ownerPassword=QByteArray(),
                            const QByteArray &userPassword=QByteArray()) /Factory, ReleaseGIL/;
    static Poppler::Document *loadFromData(const QByteArray &fileContents,
                            const QByteArray &ownerPassword=QByteArray(),
                            const QByteArray &userPassword=QByteArray()) /Factory, ReleaseGIL/;
    Poppler::Page *page(int index) const /Factory/;
    Poppler::Page *page(const QString &label) const /Factory/;
    int numPages() const;
    PageMode pageMode() const;
    PageLayout pageLayout() const;
    bool unlock(const QByteArray &ownerPassword, const QByteArray &userPassword);
    bool isLocked() const;
    QDateTime date( const QString & data ) const;
    QString info( const QString & data ) const;
    QStringList infoKeys() const;
    bool isEncrypted() const;
    bool isLinearized() const;
    bool okToPrint() const;
    bool okToPrintHighRes() const;
    bool okToChange() const;
    bool okToCopy() const;
    bool okToAddNotes() const;
    bool okToFillForm() const;
    bool okToCreateFormFields() const;
    bool okToExtractForAccessibility() const;
    bool okToAssemble() const;
%If(POPPLER_V0_16_0 -)
    bool getPdfId(QByteArray *permanentId, QByteArray *updateId) const;
%End
    void getPdfVersion(int *major, int *minor) const;
    QList<Poppler::FontInfo> fonts() const /ReleaseGIL/;
%If(POPPLER_V0_22_0 -)
    FormType formType() const;
%End
    Poppler::FontIterator* newFontIterator( int startPage = 0 ) const /Factory/;
    QByteArray fontData(const Poppler::FontInfo &font) const;
    QList<Poppler::EmbeddedFile*> embeddedFiles() const;
    bool hasEmbeddedFiles() const;
    QDomDocument *toc() const;
    Poppler::LinkDestination *linkDestination( const QString &name ) /Factory, ReleaseGIL/;
    void setPaperColor(const QColor &color);
    QColor paperColor() const;
    void setRenderBackend( RenderBackend backend );
    RenderBackend renderBackend() const;
    static QSet<Poppler::Document::RenderBackend> availableRenderBackends();
    void setRenderHint( RenderHint hint, bool on = true );
    RenderHints renderHints() const;
    Poppler::PSConverter *psConverter() const /Factory/;
    Poppler::PDFConverter *pdfConverter() const /Factory/;
    QString metadata() const;
    bool hasOptionalContent() const;
    Poppler::OptContentModel *optionalContentModel() /Factory/;
    QStringList scripts() const;
private:
    Document();
    Document(const Poppler::Document &);
        
}; // class Document


class Page {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
    ~Page();
    enum Rotation {
        Rotate0 = 0,
        Rotate90 = 1,
        Rotate180 = 2,
        Rotate270 = 3,
    };
    enum PageAction {
        Opening,
        Closing,
    };
%If(POPPLER_V0_16_0 -)
    enum TextLayout {
        PhysicalLayout,
        RawOrderLayout,
    };
    enum PainterFlag {
        DontSaveAndRestore = 0x00000001,
    };
    typedef QFlags<Poppler::Page::PainterFlag> PainterFlags;
%End
    QImage renderToImage(double xres=72.0, double yres=72.0, int x=-1, int y=-1, int w=-1, int h=-1, Rotation rotate = Rotate0) const /ReleaseGIL/;
%If(POPPLER_V0_16_0 -)
    bool renderToPainter(QPainter* painter, double xres=72.0, double yres=72.0, int x=-1, int y=-1, int w=-1, int h=-1,
                         Rotation rotate = Rotate0, PainterFlags flags = 0) const /ReleaseGIL/;
%End
    QImage thumbnail() const;
%If(POPPLER_V0_16_0 -)
    QString text(const QRectF &rect, TextLayout textLayout) const;
%End
    QString text(const QRectF &rect) const;
    enum SearchDirection {
        FromTop,
        NextResult,
        PreviousResult,
    };
    enum SearchMode {
        CaseSensitive,
        CaseInsensitive,
    };
    bool search(const QString &text, QRectF &rect, SearchDirection direction, SearchMode caseSensitive, Rotation rotate = Rotate0) const /ReleaseGIL/;
%If(POPPLER_V0_14_0 -)
    bool search(const QString &text, double &rectLeft, double &rectTop, double &rectRight, double &rectBottom, SearchDirection direction, SearchMode caseSensitive, Rotation rotate = Rotate0) const /ReleaseGIL/;
%End
    QList<Poppler::TextBox*> textList(Rotation rotate = Rotate0) const;
    QSizeF pageSizeF() const;
    QSize pageSize() const;
    Poppler::PageTransition *transition() const;
    Poppler::Link *action( PageAction act ) const;
    enum Orientation {
        Landscape,
        Portrait,
        Seascape,
        UpsideDown,
    };
    Orientation orientation() const;
    void defaultCTM(double *CTM, double dpiX, double dpiY, int rotate, bool upsideDown);
    QList<Poppler::Link*> links() const;
    QList<Poppler::Annotation*> annotations() const;
    QList<Poppler::FormField*> formFields() const;
    double duration() const;
    QString label() const;

private:
    Page();
    Page( const Poppler::Page & );
    
}; // class Page


class TextBox {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
    TextBox(const QString& text, const QRectF &bBox);
    ~TextBox();
    QString text() const;
    QRectF boundingBox() const;
    Poppler::TextBox *nextWord() const;
    QRectF charBoundingBox(int i) const;
    bool hasSpaceAfter() const;
    
private:
    TextBox(const Poppler::TextBox&);
}; // class TextBox


class FontInfo {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
    enum Type {
        unknown,
        Type1,
        Type1C,
        Type1COT,
        Type3,
        TrueType,
        TrueTypeOT,
        CIDType0,
        CIDType0C,
        CIDType0COT,
        CIDTrueType,
        CIDTrueTypeOT,
    };
    FontInfo();
//     FontInfo( const FontInfoData &fid );
    FontInfo( const Poppler::FontInfo &fi );
    ~FontInfo();
    QString name() const;
    QString file() const;
    bool isEmbedded() const;
    bool isSubset() const;
    Type type() const;
    QString typeName() const;

}; // class FontInfo


class FontIterator {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
    ~FontIterator();
    QList<Poppler::FontInfo> next();
    bool hasNext() const;
    int currentPage() const;

    Poppler::FontIterator * __iter__();
%MethodCode
    sipRes = sipCpp;
%End
    SIP_PYOBJECT __next__();
%MethodCode
    if (sipCpp->hasNext()) {
        QList<Poppler::FontInfo> next = sipCpp->next();
        sipRes = sipConvertFromType(&next, sipFindType("QList<Poppler::FontInfo>"), Py_None);
    } else {
        PyErr_SetNone(PyExc_StopIteration);
    }
%End

private:
    FontIterator(const Poppler::FontIterator&);
//     FontIterator( int, DocumentData *dd );
}; // class FontIterator


class EmbeddedFile {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
//     EmbeddedFile(EmbFile *embfile);
    ~EmbeddedFile();
    QString name() const;
    QString description() const;
    int size() const;
    QDateTime modDate() const;
    QDateTime createDate() const;
    QByteArray checksum() const;
    QString mimeType() const;
    QByteArray data();
    bool isValid() const;

private:    
    EmbeddedFile(const Poppler::EmbeddedFile&);
}; // class EmbeddedFile


class SoundObject {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
    enum SoundType {
        External,
        Embedded,
    };
    enum SoundEncoding {
        Raw,
        Signed,
        muLaw,
        ALaw,
    };
//     SoundObject(Sound *popplersound);
    ~SoundObject();
    SoundType soundType() const;
    QString url() const;
    QByteArray data() const;
    double samplingRate() const;
    int channels() const;
    int bitsPerSample() const;
    SoundEncoding soundEncoding() const;
    
private:
    SoundObject(const Poppler::SoundObject&);
}; // class SoundObject


class MovieObject {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
%End

public:
    enum PlayMode {
        PlayOnce,
        PlayOpen,
        PlayRepeat,
        PlayPalindrome,
    };
    ~MovieObject();
    QString url() const;
    QSize size() const;
    int rotation() const;
    bool showControls() const;
    PlayMode playMode() const;

private:
    MovieObject(const Poppler::MovieObject&);
}; // class MovieObject


class OptContentModel : QAbstractItemModel {
%TypeHeaderCode
#include <qt4/poppler-qt4.h>
#include <qt4/poppler-optcontent.h>
%End

public:
    virtual ~OptContentModel();

    QModelIndex index(int row, int column, const QModelIndex &parent) const;
    QModelIndex parent(const QModelIndex &child) const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent) const;

    QVariant data(const QModelIndex &index, int role) const;
    virtual bool setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole );

    Qt::ItemFlags flags ( const QModelIndex & index ) const;

    virtual QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole ) const;

private:
    OptContentModel(const Poppler::OptContentModel&);
}; // class OptContentModel


// Functions in Poppler
bool isCmsAvailable();
QDateTime convertDate (char *dateString);




}; // namespace Poppler

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
