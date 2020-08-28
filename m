Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C374255462
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgH1GPI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 02:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GPI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 02:15:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25DF20791;
        Fri, 28 Aug 2020 06:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598595307;
        bh=H2WzVL77La1wp0HOKvRgjAIPVh/JX5eWp2TxEdjd44o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAQIO1ZjwIErOdgfxeHqIyBhAO3hG8Nrklm7sZHrLVmMGv3LNeMbJM/GLkkO0+cUg
         DUyTc+MK73BBqBFSy4rvFRB1U6MsoSGHcuNFPkGie0OFQHmuOPHRuOJW0PSS3d6q0X
         hJoAZgmDZFsErmH1Az/TgMv2XJcz/3preL8EJI2k=
Date:   Fri, 28 Aug 2020 08:15:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200828061504.GC56396@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814125729.GB56456@kroah.com>
 <8bf27b82-bdd9-6486-fbc9-aa6f7a3312e0@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bf27b82-bdd9-6486-fbc9-aa6f7a3312e0@linux.microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27, 2020 at 04:45:55PM -0700, Iouri Tarassov wrote:
> 
> On 8/14/2020 5:57 AM, Greg KH wrote:
> > On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> > > Add support for a Hyper-V based vGPU implementation that exposes the
> > > DirectX API to Linux userspace.
> > 
> > Api questions:
> > 
> > > +struct d3dkmthandle {
> > > +	union {
> > > +		struct {
> > > +			u32 instance	:  6;
> > > +			u32 index	: 24;
> > > +			u32 unique	: 2;
> > 
> > What is the endian of this?
> > 
> > > +		};
> > > +		u32 v;
> > > +	};
> > > +};
> > > +
> > > +extern const struct d3dkmthandle zerohandle;
> > > +
> The definition is the same as on the Windows side. The driver communicates
> with a Windows host, so I do not expect any issues with endiannes. Windows
> currently runs only on the little endian platforms.

As I mentioned before, you need to document that somewhere (like maybe
preventing your code from being built on big endian systems?)

> User mode applications see this as an opaque 32 bit value (D3DKMTHANDLE). I
> prefer not to use the u32 definition to avoid mistakes when another integer
> or a 64-bit handle is assigned to the handle or  the handle is assigned to a
> 64 or 32 bit integer variable. There are many handles in the driver model
> (shared NT handle, d3dkmthandle, etc). Using a specific type allows to avoid
> assigning one handle to another.

Specific types are great, that is fine.

> > > +struct ntstatus {
> > > +	union {
> > > +		struct {
> > > +			int code	: 16;
> > > +			int facility	: 13;
> > > +			int customer	: 1;
> > > +			int severity	: 2;
> > 
> > Same here.
> > 
> > Are these things that cross the user/kernel boundry?
> > 
> > And why int on one and u32 on the other?
> > 
> > > +		};
> > > +		int v;
> > > +	};
> > > +};
> > > +
> "struct ntstatus" follows the definition for NTSTATUS on the Windows side.
> NTSTATUS is an integer where the negative values indicate errors. It is
> success otherwise. NTSTATUS is returned by the VM bus messages from host.
> IOCTLs from the driver return Linux negative error code or NTSTATUS positive
> success codes. DxCore applications expect certain positive success codes.
> DxCore is a shared library, which translates the D3DKMT* Windows interface
> to Linux ioctls. Applications link with DxCore to use a paravirtualized GPU.
> D3DKMTHANDLE is a 32-bit unsigned value (bitfield), not an integer.

Ok, again, please document this, and as these fields are crossing the
kernel/user boundry, use the correct types (hint, 'int' is never that
type).

> > > +struct winluid {
> > > +	uint a;
> > > +	uint b;
> > 
> > And now uint?  Come on, be consistent please :)
> Sorry about this. This came from the Windows size where we use UINT a lot.
> All uints will be replaced by u32 in the next patch set.

thank you.

greg k-h
