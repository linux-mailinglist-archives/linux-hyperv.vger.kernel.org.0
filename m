Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0FB1DB05A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2020 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETKhc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 May 2020 06:37:32 -0400
Received: from a3.inai.de ([88.198.85.195]:47924 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKhb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 May 2020 06:37:31 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id 76BFF593C1A70; Wed, 20 May 2020 12:37:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 72BB36259D2B5;
        Wed, 20 May 2020 12:37:25 +0200 (CEST)
Date:   Wed, 20 May 2020 12:37:25 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Sasha Levin <sashal@kernel.org>
cc:     Daniel Vetter <daniel@ffwll.ch>,
        Olof Johansson <olof.johansson@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Wilson, Chris" <chris@chris-wilson.co.uk>,
        "Syrjala, Ville" <ville.syrjala@linux.intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        spronovo@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        iourit@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
In-Reply-To: <20200519203608.GG33628@sasha-vm>
Message-ID: <nycvar.YFH.7.77.849.2005201222370.19642@n3.vanv.qr>
References: <20200519163234.226513-1-sashal@kernel.org> <CAKMK7uGnSDHdZha-=dZN5ns0sJ2CEnK2693uix4tzqyZb9MXCQ@mail.gmail.com> <20200519203608.GG33628@sasha-vm>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Tuesday 2020-05-19 22:36, Sasha Levin wrote:
>
>> - Why DX12 on linux? Looking at this feels like classic divide and
>
> There is a single usecase for this: WSL2 developer who wants to run
> machine learning on his GPU. The developer is working on his laptop,
> which is running Windows and that laptop has a single GPU that Windows
> is using.

It does not feel right conceptually. If the target is a Windows API
(DX12/ML), why bother with Linux environments? Make it a Windows executable,
thereby skipping the WSL translation layer and passthrough.
