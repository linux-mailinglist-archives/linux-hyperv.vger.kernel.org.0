Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05AF3CFEB0
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhGTP0V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 11:26:21 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50871 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235764AbhGTPNz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 11:13:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D673458170D;
        Tue, 20 Jul 2021 11:54:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Jul 2021 11:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Qfk4XxlZp3BZHIg5ekCwZvswEk9
        TOwHQbLRiTDcGFk8=; b=gi7Uarf6v97Nsw4SjCc8UtxORYn2ooJf7OH1qK47+Po
        M9u/fwNKgQzDJnNw7KBT0BAATuDws4o1CxKd4Upj43AX8+vAF3wTKBW8933IuHuT
        jmqqZvdZBDt6czVNfJwhfBPGo99US0F/pumT7x3oxRuJDIEae9ZrbGVNUZNUKizt
        XU2lQ+Y8JpkOCxivwJZ3bgV83sl7qjrAroXX76eqNqW+Tfu1srr1xBQLw1CMYuqd
        mvhi0O9CZ8GrTmLWPdFH55Big/IZY1m8sle0L7C3HkakLZCGDTp6vs8dPvobkk6t
        1cnO9z/rZr66Miy07rBl+3BiNK+QBU2ctn2F6rOSm+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Qfk4Xx
        lZp3BZHIg5ekCwZvswEk9TOwHQbLRiTDcGFk8=; b=tQ4pKYsMDxjgJgz1/c/e/e
        iXIEaG4tktGsB6/9R+/xJGPlaJse6HenITryRsn3AQSsmCLmBm0MkZ5Gcna8uPDn
        NajujkXmGCGh8D0ruXNh6mNPchRoRcCrvYqqCTSbI89qX1y1FsVVi0h9YJ+/KbwB
        2fHEC+YGczKW6jU2/chVTD3TpCUNw/O+ZWNXupY6wZyJreMZu9xg3v8fgKR+2dmi
        KPiO2swyi03NqJ/dOzIc/WqxWyrGWz1u3KSAJm7pWOD28coR67PPMOY/3KVW8t+1
        NAIfXlMeabRYUCAXmGyAEvacFavnzZxbebhgLMNZFNmH5hba1HVh0bYUAEpy1BZg
        ==
X-ME-Sender: <xms:svH2YJ7tJtzLnHPX0Gu7uXGRXEbPqmrGvfWSMDdqpD7MoEqvDXYY3Q>
    <xme:svH2YG48rQ8vwxYDIWSMd8DoyMA5ddpR9gkvWn_iClqkow5g_grsyXMwBJR4d8T7L
    MV69Pnkvy3lhA>
X-ME-Received: <xmr:svH2YAfn1WH5mZpQ2XXjufhPz9R2WFKacYr46KZjlnxZ7M0mDXi_Nxti8jYkKWy3Nsv8SXSJdNDAvOnFyrH8pz5GyS06aPpW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfevteeite
    etkeeiueejgedtieffueetgffgfeeigeetgeektdekgeekteduiedunecuffhomhgrihhn
    pehmihgtrhhoshhofhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:svH2YCIU-yZ_dNNG1q489Lx9sMSaTiuBagzwVJuaQsvIQ3gHOasEpQ>
    <xmx:svH2YNLimXRj5kE94J7Sw0ihk5_vvQFACah5wbG_Cx7QVoDiFp1Cgw>
    <xmx:svH2YLzbzJ2rWeT5iBwH1-V_xo2YFNNCUSFplxOFe2RBmDqfQLgwxg>
    <xmx:svH2YKDNZub-Z0N3H0AeA6550iENdPW6RSPSjf7ULWf0BPDuBkY6MA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 11:54:26 -0400 (EDT)
Date:   Tue, 20 Jul 2021 17:54:23 +0200
From:   Greg KH <greg@kroah.com>
To:     longli@linuxonhyperv.com
Cc:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Message-ID: <YPbxr8XbK0IbD02r@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 19, 2021 at 08:31:03PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Microsoft Azure Blob storage service exposes a REST API to applications
> for data access.
> (https://docs.microsoft.com/en-us/rest/api/storageservices/blob-service-rest-api)
> 
> This patchset implements a VSC (Virtualization Service Consumer) that
> communicates with a VSP (Virtualization Service Provider) on the Hyper-V
> host to execute Blob storage access via native network stack on the host.
> This VSC doesn't implement the semantics of REST API. Those are implemented
> in user-space. The VSC provides a fast data path to VSP.
> 
> Answers to some previous questions discussing the driver:
> 
> Q: Why this driver doesn't use the block layer
> 
> A: The Azure Blob is based on a model of object oriented storage. The
> storage object is not modeled in block sectors. While it's possible to
> present the storage object as a block device (assuming it makes sense to
> fake all the block device attributes), we lose the ability to express
> functionality that are defined in the REST API. 

What "REST API"?

Why doesn't object oriented storage map to a file handle to read from?
No need to mess with "blocks", why would you care about them?

And again, you loose all caching, this thing has got to be really slow,
why add a slow storage interface?  What workload requires this type of
slow block storage?

> Q: You also just abandoned the POSIX model and forced people to use a
> random-custom-library just to access their storage devices, breaking all
> existing programs in the world?
> 
> A: The existing Blob applications access storage via HTTP (REST API). They
> don't use POSIX interface. The interface for Azure Blob is not designed
> on POSIX.

I do not see a HTTP interface here, what does that have to do with the
kernel?

I see a single ioctl interface, that's all.

> Q: What programs today use this new API?
> 
> A: Currently none is released. But per above, there are also none using
> POSIX.

Great, so no one uses this, so who is asking for and requiring this
thing?

What about just doing it all from userspace using FUSE?  Why does this
HAVE to be a kernel driver?

thanks,

greg k-h
