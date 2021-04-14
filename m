Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3735F7F1
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbhDNPhL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 11:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343889AbhDNPhG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 11:37:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 545776112F;
        Wed, 14 Apr 2021 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618414604;
        bh=IwbAk1yJwB/O1SYJDmS2PsYrLOBzBT6//7Ff7sxylyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0C7phd1bfzJaIB9MO1CQPhirwdHJuQSvc7xA9ZS1wO0zI2nJ+nDHNPh/+z5F9q1u8
         u6sJtNMBkhgEBVCzqAqUxuE9XB7sp0x4/nYL32sqHBsfCyY8PJykx0VrvbqVbaAUID
         QOcw9vuYRI1BQH8AyAP3WUXOLrFYzEQYfTETihU8=
Date:   Wed, 14 Apr 2021 17:36:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: Re: [RFC V2 PATCH 8/12] UIO/Hyper-V: Not load UIO HV driver in the
 isolation VM.
Message-ID: <YHcMCn24RazskMCf@kroah.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
 <20210413152217.3386288-9-ltykernel@gmail.com>
 <YHXAL+83iHPK8O/Q@kroah.com>
 <e54446fb-f9d9-2768-f73f-01a94cf635ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54446fb-f9d9-2768-f73f-01a94cf635ea@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 14, 2021 at 11:20:19PM +0800, Tianyu Lan wrote:
> Hi Greg:
> 	Thanks for your review.
> 
> On 4/14/2021 12:00 AM, Greg KH wrote:
> > On Tue, Apr 13, 2021 at 11:22:13AM -0400, Tianyu Lan wrote:
> > > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > 
> > > UIO HV driver should not load in the isolation VM for security reason.
> > 
> > Why?  I need a lot more excuse than that.
> 
> The reason is that ring buffers have been marked as visible to host.
> UIO driver will expose these buffers to user space and user space
> driver hasn't done some secure check for data from host. This
> is considered as insecure in isolation VM.

But as this is a VM choice, why did the VM mark those as visible in the
first place?

thanks,

greg k-h
