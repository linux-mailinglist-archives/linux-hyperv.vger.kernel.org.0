Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071951D9DBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgESRVH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 13:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgESRVH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 13:21:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5E82075F;
        Tue, 19 May 2020 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589908867;
        bh=8PL4dE7cNUfHZehZe/SB0ynNQ453VlS1KvWFttiYciY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFE3bUrZOdv9Z+xlWsxW5LF+52Q2Nce+X6Lizyolxb8ktkvpNG+DsJG6sG9qXqhgA
         L0GWEtmYJt5eP3wfrBWqNl0hnzHG6iV9MCADiBcCe0+JDiez+HjdoPikVMcWwfV6MC
         9K5wTRbnAFg06tdvMOUJCpB2HjLS6hgpm9cosivI=
Date:   Tue, 19 May 2020 19:21:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-ID: <20200519172105.GB1101627@kroah.com>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519163234.226513-2-sashal@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
> +
> +#define DXGK_MAX_LOCK_DEPTH	64
> +#define W_MAX_PATH		260

We already have a max path number, why use a different one?

> +#define d3dkmt_handle		u32
> +#define d3dgpu_virtual_address	u64
> +#define winwchar		u16
> +#define winhandle		u64
> +#define ntstatus		int
> +#define winbool			u32
> +#define d3dgpu_size_t		u64

These are all ripe for a simple search/replace in your editor before you
do your next version :)

thanks,

greg k-h
