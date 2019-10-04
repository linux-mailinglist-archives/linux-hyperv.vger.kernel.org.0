Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1ECBDBF
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2019 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfJDOqS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Oct 2019 10:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388982AbfJDOqS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Oct 2019 10:46:18 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD0B222C7;
        Fri,  4 Oct 2019 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570200377;
        bh=Ey4DiqQrWKa03eKiFS7E7aglMxSH9E2XGnUFGeNz/9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZDhXJDg3TvHeU0QlMme/s9FDITamJb6H5U3uo44vJoUtrL8Riaun3VD2RBXk0t19
         8pcxGRGQ6btyaVtX70IIw6Er1+Rqt4IRkD4JqezaoBf+KOz10faXIzaY/7upvPfTN7
         vmgdD1e2GpwfLf+LQgl+eb9XmOiA/s+98lDO9874=
Date:   Fri, 4 Oct 2019 10:46:16 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Branden Bonaby <brandonbonaby94@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] hv: vmbus: add fuzz testing to hv device
Message-ID: <20191004144616.GH17454@sasha-vm>
References: <cover.1570130325.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1570130325.git.brandonbonaby94@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 03, 2019 at 05:01:36PM -0400, Branden Bonaby wrote:
>This patchset introduces a testing framework for Hyper-V drivers.
>This framework allows us to introduce delays in the packet receive
>path on a per-device basis. While the current code only supports
>introducing arbitrary delays in the host/guest communication path,
>we intend to expand this to support error injection in the future.

I've queued it up for hyperv-next, thanks!

--
Thanks,
Sasha
