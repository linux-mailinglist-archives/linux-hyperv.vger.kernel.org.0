Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD0586123
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Jul 2022 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiGaUAr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 31 Jul 2022 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaUAq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 31 Jul 2022 16:00:46 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C4DF72
        for <linux-hyperv@vger.kernel.org>; Sun, 31 Jul 2022 13:00:45 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id IF7CoUO8ZcdW9IF7CoxqKI; Sun, 31 Jul 2022 22:00:43 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 22:00:43 +0200
X-ME-IP: 90.11.190.129
Message-ID: <b92e535f-1683-e7f6-2bb4-da873605274f@wanadoo.fr>
Date:   Sun, 31 Jul 2022 22:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hyperv_setup_vram() calls vmbus_allocate_mmio(). This
 must be undone in the error handling path of the probe, as already done in
 the remove function.
Content-Language: fr
To:     Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1781855facffbdba640ce2da3649cac424e76fed.1659297462.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1781855facffbdba640ce2da3649cac424e76fed.1659297462.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Le 31/07/2022 à 21:57, Christophe JAILLET a écrit :
> This patch depends on	commit a0ab5abced55 ("drm/hyperv : Removing the
> restruction of VRAM allocation with PCI bar size").
> Without it, something like what is done in commit e048834c209a
> ("drm/hyperv: Fix device removal on Gen1 VMs") should be done.

I forgot the subject :(
Will resend.

CJ

