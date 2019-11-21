Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A7105481
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2019 15:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUOeQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Nov 2019 09:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUOeQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Nov 2019 09:34:16 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBB6206CB;
        Thu, 21 Nov 2019 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574346855;
        bh=5CMaaOO4eBpqQf/mskysv4t+TyWb8N0Oi/MlxYQTaUk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KmhNfsre7QrBN12iGR5H11VP5Zg35Pv2lwKFHbF6msmHXrr/nqxbkFDuYp2UaaQBN
         zCf3JBOAiP38ktfRjyCBY4UtKTrWbuSRACYC7MG00iaYDSMjUNTZ3HWyCXYCOAZXAb
         R34feB0f7wQWdeQAfpZcdYFWHTN6aJEW4UP7Iyig=
Date:   Thu, 21 Nov 2019 15:34:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, benjamin.tissoires@redhat.com,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH v2] HID: hyperv: Add the support of hibernation
In-Reply-To: <1574234096-48767-1-git-send-email-decui@microsoft.com>
Message-ID: <nycvar.YFH.7.76.1911211533430.1799@cbobk.fhfr.pm>
References: <1574234096-48767-1-git-send-email-decui@microsoft.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 19 Nov 2019, Dexuan Cui wrote:

> During the suspend process and resume process, if there is any mouse
> event, there is a small chance the suspend and the resume process can be
> aborted because of mousevsc_on_receive() -> pm_wakeup_hard_event().
> 
> This behavior can be avoided by disabling the Hyper-V mouse device as
> a wakeup source:
> 
> echo disabled > /sys/bus/vmbus/drivers/hid_hyperv/XXX/power/wakeup
> (XXX is the device's GUID).
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Acked-by: Jiri Kosina <jkosina@suse.cz>

My Ack still holds for v2. Sasha, this is going to be merged through your 
tree, right?

Thanks,

-- 
Jiri Kosina
SUSE Labs

