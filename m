Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCC48D306
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiAMHl2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 02:41:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34496 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiAMHl1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 02:41:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C41D61BC2;
        Thu, 13 Jan 2022 07:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5977C36AE3;
        Thu, 13 Jan 2022 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642059686;
        bh=7T1JxJvHTbOGtPGyoSos1nBsMxQ46XbRG2c38qhM9tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZhRQzKgUpcPsF86aupuh3MozA0WA/QZec+dxrIYdwp3tG8hDaDpnHAjuNDWHwcr4
         tvhsJBv0i4QHf3o8kMGa9gw1cD6TdsfMs+TVXHesDltwMSwlXuUVJjO5nFtBEgIrhg
         ejhV5XcG+8r3nzRrbenG0oRQLZfGhGJ561L6cfTI=
Date:   Thu, 13 Jan 2022 08:41:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 2/9] drivers: hv: dxgkrnl: Open device object, adapter
 enumeration, dxgdevice, dxgcontext creation
Message-ID: <Yd/XoqaEebbmj9VN@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <79cf6932161dd52c226c9f7a729b5b3a0a217fc3.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cf6932161dd52c226c9f7a729b5b3a0a217fc3.1641937419.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 12, 2022 at 11:55:07AM -0800, Iouri Tarassov wrote:
> - Handle opening of the device (/dev/dxg) file object and creation of
> dxgprocess. dxgprocess is created for each process, which opens /dev/dxg.
> dxgprocess is ref counted, so the exicting dxgprocess objects is used for
> a process, which opens the device object multiple time.
> dxgprocess is destroyed when the device object is closed.
> 
> - Implement ioctls for virtual GPU adapter enumeration:
> LX_DXENUMADAPTERS2, LX_DXENUMADAPTERS3
> The IOCTLs return a d3dkmt handle for each enumerated adapter.
> 
> - Implement ioctl to query adapter information:
> LX_DXQUERYADAPTERINFO.
> 
> - Implement ioctls to open and closet a dxgadapter object:
> LX_DXOPENADAPTERFROMLUID, LX_DXCLOSEADAPTER
> Note that dxgadapter is opened when LX_DXENUMADAPTERS2, LX_DXENUMADAPTERS3
> are called.
> 
> - Implement ioctls for dxgdevice and dxgcontext creation/destruction:
> LX_DXCREATEDEVICE, LX_DXCREATECONTEXT, LX_DXCREATECONTEXTVIRTUAL,
> LX_DXDESTROYCONTEXT, LX_DXCREATEHWCONTEXT, LX_DXDESTROYDEVICE,
> LX_DXDESTROYHWCONTEXT

Hint, when you have to list all of the different things you are doing in
a single commit, that is a good clue that you should be splitting up the
commit into "one per thing".

This commit has way too many things happening all at once, and is very
difficult to review because of that.  What would you do if you were
confronted with a single patch like this and you had to review it?

Make it trivial to review, please break this up into smaller pieces.

thanks,

greg k-h
