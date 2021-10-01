Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C136841E86E
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Oct 2021 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhJAHiM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Oct 2021 03:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231222AbhJAHiI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Oct 2021 03:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B28D61A56;
        Fri,  1 Oct 2021 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633073784;
        bh=F7FORTn48/F8tKh/vrqU2iD+S5SdTTcOrGHdRF5xuhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUgDaxumqVLgqn5UYFFs4mpQVt+mTF64KU4Ol2Hpz3AXUJbyqqHxxqzpxpovAyl17
         dIw9UynDCXMIIzcTu011qomNHpSpWZm7DFTqorTSwaUFVQc9MJx728NI3CVmq2vf9E
         b911fk7Qfn0pqUfUDFQ9SJOCE+OaLeByr8CHx7ME=
Date:   Fri, 1 Oct 2021 09:36:22 +0200
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
Message-ID: <YVa6dtvt/BaajmmK@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 30, 2021 at 10:25:12PM +0000, Long Li wrote:
> > Greg,
> > 
> > I apologize for the delay. I have attached the Java transport library (a tgz file)
> > in the email. The file is released for review under "The MIT License (MIT)".
> > 
> > The transport library implemented functions needed for reading from a Block
> > Blob using this driver. The function for transporting I/O is
> > Java_com_azure_storage_fastpath_driver_FastpathDriver_read(), defined
> > in "./src/fastpath/jni/fpjar_endpoint.cpp".
> > 
> > In particular, requestParams is in JSON format (REST) that is passed from a
> > Blob application using Blob API for reading from a Block Blob.
> > 
> > For an example of how a Blob application using the transport library, please
> > see Blob support for Hadoop ABFS:
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> > ub.com%2Fapache%2Fhadoop%2Fpull%2F3309%2Fcommits%2Fbe7d12662e2
> > 3a13e6cf10cf1fa5e7eb109738e7d&amp;data=04%7C01%7Clongli%40microsof
> > t.com%7C3acb68c5fd6144a1857908d97e247376%7C72f988bf86f141af91ab2d7
> > cd011db47%7C1%7C0%7C637679518802561720%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D%7C1000&amp;sdata=6z3ZXPtMC5OvF%2FgrtbcRdFlqzzR1xJNRxE2v2Qrx
> > FL8%3D&amp;reserved=0

Odd url :(

> > In ABFS, the entry point for using Blob I/O is at AbfsRestOperation
> > executeRead() in hadoop-tools/hadoop-
> > azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsInputStr
> > eam.java, from line 553 to 564, this function eventually calls into
> > executeFastpathRead() in hadoop-tools/hadoop-
> > azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsClient.ja
> > va.
> > 
> > ReadRequestParameters is the data that is passed to requestParams
> > (described above) in the transport library. In this Blob application use-case,
> > ReadRequestParameters has eTag and sessionInfo (sessionToken). They are
> > both defined in this commit, and are treated as strings passed in JSON format
> > to I/O issuing function
> > Java_com_azure_storage_fastpath_driver_FastpathDriver_read() in the
> > transport library using this driver.
> > 
> > Thanks,
> > Long
> 
> Hello Greg,
> 
> I have shared the source code of the Blob client using this driver, and the reason why the Azure Blob driver is not implemented through POSIX with file system and Block layer.

Please wrap your text lines...

Anyway, no, you showed a client for this interface, but you did not
explain why this could not be implemented using a filesystem and block
layer.  Only that it is not what you did.

> Blob APIs are specified in this doc:
> https://docs.microsoft.com/en-us/rest/api/storageservices/blob-service-rest-api
> 
> The semantic of reading data from Blob is specified in this doc:
> https://docs.microsoft.com/en-us/rest/api/storageservices/get-blob
> 
> The source code I shared demonstrated how a Blob is read to Hadoop through ABFS. In general, A Blob client can use any optional request headers specified in the API suitable for its specific application. The Azure Blob service is not designed to be POSIX compliant. I hope this answers your question on why this driver is not implemented at file system or block layer.


Again, you are saying "it is this way because we created it this way",
which does not answer the question of "why were you required to do it
this way", right?

> Do you have more comments on this driver?

Again, please answer _why_ you are going around the block layer and
creating a new api that circumvents all of the interfaces and
protections that the normal file system layer provides.  What is lacking
in the existing apis that has required you to create a new one that is
incompatible with everything that has ever existed so far?

thanks,

greg k-h
