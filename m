Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30F0966CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHTQvr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 12:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHTQvr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 12:51:47 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 964442054F;
        Tue, 20 Aug 2019 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566319906;
        bh=E7VuqcRkF1j+Q5+SBoX6GeQAavUN+Ir6A1fbOhqfQ8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMIgs1CdcDRp3OzP67C/8GHfWRSt9MHeR6wWzIFcoSw+2KOCfppf59j/RhNvYjyVv
         q2kFmnYJGATv480fUa2r7Q9IZvBIdfggxOYqUlJzBqGiCK/Joj9G+/fZth/XUrGXwt
         AF2OZ/ZRQK28ywDrJRh9uDuVHjUWkx3EezBoh894=
Date:   Tue, 20 Aug 2019 12:51:46 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE
Message-ID: <20190820165146.GP30205@sasha-vm>
References: <1557215147-89776-1-git-send-email-decui@microsoft.com>
 <DM5PR2101MB09188A7DB0777CD50333F94ED7310@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190509010600.GQ1747@sasha-vm>
 <06e0ae5e-2fb0-5dac-a1a5-5583fdda334f@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <06e0ae5e-2fb0-5dac-a1a5-5583fdda334f@intra2net.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 20, 2019 at 05:51:39PM +0200, Juliana Rodrigueiro wrote:
>Hi Sasha.
>
>I haven't spotted the following patch in the hyperv-fixes branch.
>
>Did I look in the wrong place or it was not applied?

I've previously dropped it, it's in there now.

--
Thanks,
Sasha
