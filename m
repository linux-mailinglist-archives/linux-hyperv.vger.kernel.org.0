Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218378B3A0
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjH1Ovk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjH1OvH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 10:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F1103;
        Mon, 28 Aug 2023 07:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7C960FEC;
        Mon, 28 Aug 2023 14:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4895BC433C8;
        Mon, 28 Aug 2023 14:51:03 +0000 (UTC)
Date:   Mon, 28 Aug 2023 16:51:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, daniel@ffwll.ch, sam@ravnborg.org,
        javierm@redhat.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 7/8] staging/fbtft: Initialize fb_op struct as static
 const
Message-ID: <2023082854-appetite-unmindful-73f4@gregkh>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828132131.29295-8-tzimmermann@suse.de>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 28, 2023 at 03:14:23PM +0200, Thomas Zimmermann wrote:
> Replace dynamic allocation of the fb_ops instance with static
> allocation. Initialize the fields at module-load time. The owner
> field changes to THIS_MODULE, as in all other fbdev drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
