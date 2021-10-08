Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A076B42644E
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 07:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhJHF44 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 01:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhJHF4z (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 01:56:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1951C60F46;
        Fri,  8 Oct 2021 05:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633672501;
        bh=tVO3GMXQe9fBMBvY0KOxHGoMswwjOELDXXkn1OVMUdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOAPlaOM9w+nd7eg6MKY3FcyWmZz9CduIXG3aatOqTR3zw4JUBRrD+IKDhsbh17jR
         lPVYbZbOWO8YTEy1aIIJlZHq+8WPHWHYRtFYamT+o3FKCgzXqZ1cd2mOwe+3T95pim
         cj4Vw7psfhbRs70QCy2mDaevbyySLVZSPHIoH2FQ=
Date:   Fri, 8 Oct 2021 07:54:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Message-ID: <YV/dMdcmADXH/+k2@kroah.com>
References: <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 07, 2021 at 06:15:25PM +0000, Long Li wrote:
> > Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
> > access to Microsoft Azure Blob for Azure VM
> > 
> > On Thu, Sep 30, 2021 at 10:25:12PM +0000, Long Li wrote:
> > > > Greg,
> > > >
> > > > I apologize for the delay. I have attached the Java transport
> > > > library (a tgz file) in the email. The file is released for review under "The
> > MIT License (MIT)".
> > > >
> > > > The transport library implemented functions needed for reading from
> > > > a Block Blob using this driver. The function for transporting I/O is
> > > > Java_com_azure_storage_fastpath_driver_FastpathDriver_read(),
> > > > defined in "./src/fastpath/jni/fpjar_endpoint.cpp".
> > > >
> > > > In particular, requestParams is in JSON format (REST) that is passed
> > > > from a Blob application using Blob API for reading from a Block Blob.
> > > >
> > > > For an example of how a Blob application using the transport
> > > > library, please see Blob support for Hadoop ABFS:
> > > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > > th
> > > >
> > ub.com%2Fapache%2Fhadoop%2Fpull%2F3309%2Fcommits%2Fbe7d12662e2
> > > >
> > 3a13e6cf10cf1fa5e7eb109738e7d&amp;data=04%7C01%7Clongli%40microsof
> > > >
> > t.com%7C3acb68c5fd6144a1857908d97e247376%7C72f988bf86f141af91ab2d7
> > > >
> > cd011db47%7C1%7C0%7C637679518802561720%7CUnknown%7CTWFpbGZsb
> > > >
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > > %3D%7C1000&amp;sdata=6z3ZXPtMC5OvF%2FgrtbcRdFlqzzR1xJNRxE2v2
> > Qrx
> > > > FL8%3D&amp;reserved=0
> > 
> > Odd url :(
> > 
> > > > In ABFS, the entry point for using Blob I/O is at AbfsRestOperation
> > > > executeRead() in hadoop-tools/hadoop-
> > > >
> > azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsInput
> > > > Str eam.java, from line 553 to 564, this function eventually calls
> > > > into
> > > > executeFastpathRead() in hadoop-tools/hadoop-
> > > > azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsClien
> > > > t.ja
> > > > va.
> > > >
> > > > ReadRequestParameters is the data that is passed to requestParams
> > > > (described above) in the transport library. In this Blob application
> > > > use-case, ReadRequestParameters has eTag and sessionInfo
> > > > (sessionToken). They are both defined in this commit, and are
> > > > treated as strings passed in JSON format to I/O issuing function
> > > > Java_com_azure_storage_fastpath_driver_FastpathDriver_read() in the
> > > > transport library using this driver.
> > > >
> > > > Thanks,
> > > > Long
> > >
> > > Hello Greg,
> > >
> > > I have shared the source code of the Blob client using this driver, and the
> > reason why the Azure Blob driver is not implemented through POSIX with file
> > system and Block layer.
> > 
> > Please wrap your text lines...
> > 
> > Anyway, no, you showed a client for this interface, but you did not explain
> > why this could not be implemented using a filesystem and block layer.  Only
> > that it is not what you did.
> > 
> > > Blob APIs are specified in this doc:
> > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> > > .microsoft.com%2Fen-us%2Frest%2Fapi%2Fstorageservices%2Fblob-
> > service-r
> > > est-
> > api&amp;data=04%7C01%7Clongli%40microsoft.com%7C6a51f21c78a3413e63
> > >
> > 9d08d984ae2c58%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376
> > 867059
> > >
> > 24012728%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luMzIiL
> > >
> > CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZiWmZ%2FpuQHNn
> > dHNmnIWHO
> > > yrXPSscNBbR6RvSr%2FCBuEY%3D&amp;reserved=0
> > >
> > > The semantic of reading data from Blob is specified in this doc:
> > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> > > .microsoft.com%2Fen-us%2Frest%2Fapi%2Fstorageservices%2Fget-
> > blob&amp;d
> > >
> > ata=04%7C01%7Clongli%40microsoft.com%7C6a51f21c78a3413e639d08d984a
> > e2c5
> > >
> > 8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63768670592401272
> > 8%7CUn
> > >
> > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > Ik1haW
> > >
> > wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xqUObAdYkFf8efSRuK%2FOXm%2
> > BRd%2FCiBI
> > > 0BjNfx9YpkGN0%3D&amp;reserved=0
> > >
> > > The source code I shared demonstrated how a Blob is read to Hadoop
> > through ABFS. In general, A Blob client can use any optional request headers
> > specified in the API suitable for its specific application. The Azure Blob service
> > is not designed to be POSIX compliant. I hope this answers your question on
> > why this driver is not implemented at file system or block layer.
> > 
> > 
> > Again, you are saying "it is this way because we created it this way", which
> > does not answer the question of "why were you required to do it this way",
> > right?
> > 
> > > Do you have more comments on this driver?
> > 
> > Again, please answer _why_ you are going around the block layer and
> > creating a new api that circumvents all of the interfaces and protections that
> > the normal file system layer provides.  What is lacking in the existing apis that
> > has required you to create a new one that is incompatible with everything
> > that has ever existed so far?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hello Greg,
> 
> Azure Blob is massively scalable and secure object storage designed for cloud native 
> workloads. Many of its features are not possible to implement through POSIX file 
> system. Please find some of them below:
>  
> For read and write API calls (for both data and metadata) Conditional Support 
> (https://docs.microsoft.com/en-us/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations) 
> is supported by Azure Blob. Every change will result in an update to the Last Modified 
> Time (== ETag) of the changed file and customers can use If-Modified-Since, If-Unmodified-Since, 
> If-Match, and If-None-Match conditions. Furthermore, almost all APIs support this 
> since customers require fine-grained and complete control via these conditions. It 
> is not possible/practical to implement Conditional Support in POSIX filesystem.
>  
> The Blob API supports multiple write-modes of files with three different blob types: 
> Block Blobs (https://docs.microsoft.com/en-us/rest/api/storageservices/operations-on-block-blobs), 
> Append Blobs, and Page Blobs. Block Blobs support very large file sizes (hundreds 
> of TBs in a single file) and are more optimal for larger blocks, have two-phased 
> commit protocol, block sharing, and application control over block identifiers. Block 
> blobs support both uncommitted and committed data. Block blobs allow the user to 
> stage a series of modifications, then atomically update the block list to incorporate 
> multiple disjoint updates in one operation. This is not possible in POSIX filesystem.
>  
> Azure Blob supports Blob Tiers (https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview). 
> The "Archive" tier is not possible to implement in POSIX file system. To access data 
> from an "Archive" tier, it needs to go through rehydration (https://docs.microsoft.com/en-us/azure/storage/blobs/archive-rehydrate-overview) 
> to become "Cool" or "Hot" tier. Note that the customer requirement for tiers is that 
> they do not change what URI, endpoint, or file/folder they access at all - same endpoint, 
> same file path is a must requirement. There is no POSIX semantics to describe Archive 
> and Rehydration, while maintaining the same path for the data.
>  
> The Azure Blob feature Customer Provided Keys (https://docs.microsoft.com/en-us/azure/storage/blobs/encryption-customer-provided-keys) 
> provides different encryption key for data at a per-request level. It's not possible 
> to inject this into POSIX filesystem and it is a critical security feature for customers 
> requiring higher level of security such as the Finance industry customers. There 
> exists file-level metadata implementation that indicates info about the encryption 
> as well. Note that encryption at file/folder level or higher granularity does not 
> meet such customers' needs - not just on individual customer requirements but also 
> related financial regulations.
>  
> The Immutable Storage (https://docs.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview) 
> feature is not possible with POSIX filesystem. This provides WORM (Write-Once Read-Many) 
> guarantees on data where it is impossible (regardless of access control, i.e. even 
> the highest level administrator/root) to modify/delete data until a certain interval 
> has passed; it also includes features such as Legal Hold. Note that per the industry 
> and security requirements, the store must enforce these WORM and Legal Hold aspects 
> directly, it cannot be done with access control mechanisms or enforcing this at the 
> various endpoints that access the data.
>   
> Blob Index (https://docs.microsoft.com/en-us/azure/storage/blobs/storage-manage-find-blobs) 
> which provides multi-dimensions secondary indexing on user-settable blob tags (metadata) 
> is not possible to accomplish in POSIX filesystem. The indexing engine needs to incorporate 
> with Storage access control integration, Lifecycle retention integration, runtime 
> API call conditions, it's not possible to support in the filesystem itself; in other 
> words, it cannot be done as a side-car or higher level service without compromising 
> on the customer requirements for Blob Index. Related Blob APIs for this are Set Blob 
> Tags (https://docs.microsoft.com/en-us/rest/api/storageservices/set-blob-tags) and 
> Find Blob by Tags (https://docs.microsoft.com/en-us/rest/api/storageservices/find-blobs-by-tags).

You are mixing up a lot of different things here all at once.

You are confusing the actions that a file server must implement with how
a userspace interface should look like for an in-kernel functionality.

Not to mention the whole crazy idea of "let's implement our REST api
that used to go over a network connection over an ioctl instead!"
That's the main problem that you need to push back on here.

What is forcing you to put all of this into the kernel in the first
place?  What's wrong with the userspace network connection/protocol that
you have today?

Does this mean that we now have to implement all REST apis that people
dream up as ioctl interfaces over a hyperv transport?  That would be
insane.

thanks,

greg k-h
