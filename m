Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366583D082B
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 07:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhGUEiN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 00:38:13 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44289 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhGUEiM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 00:38:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2B8DA581865;
        Wed, 21 Jul 2021 01:18:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 21 Jul 2021 01:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=WhrD41ffNVn/36YzYIxJtzJhx5w
        mUJTqLi2n9GMPzkE=; b=FSjejb7MRbDSICcqsuMdzuSjh8rWEsLU9Kgilxvohks
        znnl/nHLkx95D1OxXrxCzWWnBwSKOL00DWCeLhQxQUVdn2LcIP5FkqHPUgj1CIPk
        F/hnSZxroLlJZ2UgHmQc5HY3Sj2cCVm/6enlWnRNXpEJS0To3Zic+1vs1qZZ7nKP
        FySFnJC22EsyxkXZdg1klXyu7pmbxXbE+l00Lit6EVZodvvAvgKVBjwCi3bGddJq
        NyNub+jSgwoDJAxq3n/5qHnAsW9slaD/eeln91su7j3yt5xi+jstE9gzF3SkjTIn
        4ZDsxN4EZ1wZiokYet+oGQIPsR14NemFf7FbY2qwloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WhrD41
        ffNVn/36YzYIxJtzJhx5wmUJTqLi2n9GMPzkE=; b=iEq4rN4hH1UwfZIBRhx3d/
        wQ2bwgGx+RWD+hZ+Ch3WoAX/BiRnOhlyOPD0mivDIwfneNS2M4K62sdNDmO2dAS3
        mJTuHaYT2tAPZZIHluKqAqpbe2iDr8AOIQR3J9kW+9lQoMdGEOI5PCtJ9ZIOW5XN
        2ipoi+A4a5s7ABbZonGV0HOjw214l9dIRizIhyiqxZzgt26eFPlaQRbedvj2CqDG
        qCdywM1C3lsghLp1D5nzKx8R+IOk/KRj+D3Ucwxw+VKFSoDkf5TKlqk/V6eCiei9
        FXn2i3Ak0WziAFs09RwYA7FkduqY5sVGMxLuzq/mJXFVmCpgUXxQDt5/AOhLaxOg
        ==
X-ME-Sender: <xms:OK73YLI83JT2i4oP18auMfPE2dYb9yi6kg8ofSRyPrjBqhm2ckWD2g>
    <xme:OK73YPLfW9iRtx2ISV33U0g3WPIA-uWk-Ma4lkVE-C-vuM92NLewiu51WLhdE1Fo1
    y7iYGhZWQ_5-g>
X-ME-Received: <xmr:OK73YDseyvCUciRO3cljxFI6IzrD-T5Pvl4llG4JKaXOzwxcKxPD19UrKXcJX3Y4y3VnE7UWFiYYusIk_ng9Ntaha7oDfgSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeefgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhephfelffejgf
    eludeljeeivdegleekveeffeeigeduheffteegveelteeuleffveeknecuffhomhgrihhn
    pehouhhtlhhoohhkrdgtohhmpdhhthhtphdrihhnpdhgihhthhhusgdrtghomhdpmhhitg
    hrohhsohhfthdrtghomhdphhhtthhprdhithenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:OK73YEZNf2qMmzVMsCojj13dOT5Q4wL8zY2fLhZLeB-hivP7CfNBlw>
    <xmx:OK73YCaPbORg9Eb2UaQPfLF6JuoZiqymgIAMpVtvIR1-PV29JLBmtg>
    <xmx:OK73YICzwzbYTpYql64YWp94GGPQ8Uozc014PU7IcOEPeeu0glTnqg>
    <xmx:Oa73YPQ2TYbANtu5X6RkYhbk47SEfJw_MJrEohZJeYViD5CK5Exd0g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 01:18:48 -0400 (EDT)
Date:   Wed, 21 Jul 2021 07:18:44 +0200
From:   Greg KH <greg@kroah.com>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Message-ID: <YPeuND2rmiLnbJig@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <YPbxr8XbK0IbD02r@kroah.com>
 <BY5PR21MB1506D5D10F15E291BB553B50CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506D5D10F15E291BB553B50CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 06:37:38PM +0000, Long Li wrote:
> > Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
> > access to Microsoft Azure Blob
> > 
> > On Mon, Jul 19, 2021 at 08:31:03PM -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > Microsoft Azure Blob storage service exposes a REST API to
> > > applications for data access.
> > >
> > (https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdoc
> > > s.microsoft.com%2Fen-us%2Frest%2Fapi%2Fstorageservices%2Fblob-
> > service-
> > > rest-
> > api&amp;data=04%7C01%7Clongli%40microsoft.com%7Ce499fbe161554232e
> > >
> > b1608d94b96a772%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637
> > 623932
> > >
> > 843247787%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> > oiV2luMzIi
> > >
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=9CKNHAmurdBWp
> > ZeLfkiC18
> > > CXNg66UhKsSZzzHZkzf0Y%3D&amp;reserved=0)
> > >
> > > This patchset implements a VSC (Virtualization Service Consumer) that
> > > communicates with a VSP (Virtualization Service Provider) on the
> > > Hyper-V host to execute Blob storage access via native network stack on
> > the host.
> > > This VSC doesn't implement the semantics of REST API. Those are
> > > implemented in user-space. The VSC provides a fast data path to VSP.
> > >
> > > Answers to some previous questions discussing the driver:
> > >
> > > Q: Why this driver doesn't use the block layer
> > >
> > > A: The Azure Blob is based on a model of object oriented storage. The
> > > storage object is not modeled in block sectors. While it's possible to
> > > present the storage object as a block device (assuming it makes sense
> > > to fake all the block device attributes), we lose the ability to
> > > express functionality that are defined in the REST API.
> > 
> > What "REST API"?
> > 
> > Why doesn't object oriented storage map to a file handle to read from?
> > No need to mess with "blocks", why would you care about them?
> > 
> > And again, you loose all caching, this thing has got to be really slow, why add
> > a slow storage interface?  What workload requires this type of slow block
> > storage?
> 
> "Blob REST API" expresses storage request semantics through HTTP. In Blob
> REST API, each request is associated with a context meta data expressed in
> HTTP headers. The ability to express those semantics is rich, it's only limited
> by HTTP protocol.

HTTP has nothing to do with the kernel, so I do not understand what you
are talking about here.

> There are attempts to implement the Blob as a file system.
> Here is an example filesystem (BlobFuse) implemented for Blob:
> (https://github.com/Azure/azure-storage-fuse).
> 
> It's doable, but at the same time you lose all the performance and
> shareable/security features presented in the REST API for Blob.

What sharable/security features are in this driver instead?  I saw none.

> A POSIX
> interface cannot express same functionality as the REST API for Blob.

But you are not putting a REST api into this kernel driver, so I fail to
understand this.

> For example, The Blob API for read (Get Blob, 
> https://docs.microsoft.com/en-us/rest/api/storageservices/get-blob)
> has rich meta data context that cannot easily be mapped to POSIX. The same
> goes to other Blob API to manage security tokens and the life cycle of shareable
> objects.

How can you have sharable objects in this ioctl interface instead?

> BlobFuse (above) filesystem demonstrated why Blob should not be implemented
> on a filesystem. It's useable for data management purposes. It's not usable for an I/O
> intensive workload. It's not usable for managing sharable objects and security tokens.

What is the bottleneck for the throughput/performance issues involved?

> Blob is designed not to use file system caching and block layer I/O scheduling.
> There are many solutions existing today, that access raw disk for I/O, bypassing
> filesystem and block layer. For example, many database applications access raw
> disks for I/O. When the application knows the I/O pattern and its intended behavior,
> it doesn't get much benefit from filesystem or block.

Databases that use raw i/o "know what they are doing" and are constantly
fighting with the kernel.  Don't expect kernel developers to just think
that this is ok.

But this is not what you are doing here at all, this is an object
storage, you are still being forced to open/ioctl/close to get an object
instead of just doing open/read/close, so I fail to understand where the
performance issues are.

And if they are in the FUSE layer, why not just write a filesystem layer
in the kernel instead to resolve that?  Who is insisting that you do
this through a character device driver to get filesystem data?

> > > Q: You also just abandoned the POSIX model and forced people to use a
> > > random-custom-library just to access their storage devices, breaking
> > > all existing programs in the world?
> > >
> > > A: The existing Blob applications access storage via HTTP (REST API).
> > > They don't use POSIX interface. The interface for Azure Blob is not
> > > designed on POSIX.
> > 
> > I do not see a HTTP interface here, what does that have to do with the kernel?
> > 
> > I see a single ioctl interface, that's all.
> 
> The driver doesn't attempt to implement Blob API or HTTP. It presents a fast data
> path to pass Blob requests to hosts, so the guest VM doesn't need to assemble
> a HTTP packet for each Blob REST requests. This also eliminates additional
> overhead in guest network stack to send the HTTP packets over TCP/IP.

Again, I fail to understand how http or tcp/ip comes into play here at
all, that's not what this driver does.

> Once the request reaches the Azure host, it knows the best way to reach to the 
> backend storage and serving the Blob request, while at the same time all the 
> security and integrity features are preserved.

I do not understand this statement at all.

> > > Q: What programs today use this new API?
> > >
> > > A: Currently none is released. But per above, there are also none
> > > using POSIX.
> > 
> > Great, so no one uses this, so who is asking for and requiring this thing?
> > 
> > What about just doing it all from userspace using FUSE?  Why does this HAVE
> > to be a kernel driver?
> 
> We have a major workload nearing the end of development. Compared with
> REST over HTTP, this device model presented faster data access and CPU savings
> in that there is no overhead of sending HTTP over network.

Your development cycle means nothing to us, sorry.  Please realize that
if you submit something that is not acceptable to us, there is no
requirement that we take it just because we feel this is implemented in
totally the wrong way.

And you have not, again, proven that there is any performance
improvement anywhere due to lack of numbers and data.   And again, what
does HTTP have to do with this driver.

> Eventually, all the existing Blob REST API applications can use this new API, once
> it gets to their Blob transport libraries.

What applications?  What libraries?  Who is using any of this?

> I have explained why BlobFuse is not suitable for production workloads. There
> are people using BlobFuse but mostly for management purposes.

I fail to see why it is not usable as you have not provided any real
information, sorry.

Please step back and write up a document that explains the problem you
are trying to solve and then we can go from there.  Right now you are
throwing a driver at us and expecting us to just accept it, despite it
looking like it is completly wrong for the problem space it is
attempting to interact with.

Please work with some experienced Linux kernel developers on your team
to do all of this _BEFORE_ submitting it to the community again.  Based
on the mistakes made so far, it looks like you could use some guidance
in turning this into something that might be acceptable.  As it is, you
are a long way off.

good luck!

greg k-h
