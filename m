Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652EF449D80
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhKHVF3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 16:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhKHVF2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 16:05:28 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD09C061570
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Nov 2021 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V0YEk6A58sEIDXhILo4RK/OlyTDAV7LyAsAqZL6Dyvk=; b=Anlh4bv3FglAiUuqcdKKbEcLyH
        v8LtWBfpHwngaOh7KNsYHjR/8bDIGF0liowggGmVP+AxohGZmClvb2j9k3aM9rKxhFpG5X58Wg9NL
        NaaItiLrl5dJRT5hQIjyA/H7jWvtZsx2MjXYU3od71fDSXYDsjE7vLqyhv3IqBBMT9tFndgJqrk3h
        Dp6dgr5OsL1pu7mSjnU5GWg3lTFfQozYBxZ+GaXE33sRrEt0aksgyUAGtH+ROboWSvV/5zhINXdfE
        EIUlvvnc8+SEtDxo6NwJiNJiMWHreXroIGrsBbsVswnWmxYNNmTp2p+jSq8rlTAvVw55HDKetJ7bd
        vWTE49gw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:55184 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mkBmr-0003A0-SB; Mon, 08 Nov 2021 22:02:41 +0100
Subject: Re: [PATCH v2 9/9] drm: Clarify semantics of struct
 drm_mode_config.{min,max}_{width,height}
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, drawat.floss@gmail.com,
        airlied@redhat.com, kraxel@redhat.com, david@lechnology.com,
        sam@ravnborg.org, javierm@redhat.com, kernel@amanoeldawod.com,
        dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-10-tzimmermann@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <74ab5851-ce85-ef01-4514-f729f006b9ba@tronnes.org>
Date:   Mon, 8 Nov 2021 22:02:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101141532.26655-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Den 01.11.2021 15.15, skrev Thomas Zimmermann:
> Add additional information on the semantics of the size fields in
> struct drm_mode_config. Also add a TODO to review all driver for
> correct usage of these fields.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
