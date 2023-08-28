Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175D878B3AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjH1Ovl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjH1OvV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 10:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2221C110;
        Mon, 28 Aug 2023 07:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5A5A62FC3;
        Mon, 28 Aug 2023 14:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95AFC433CA;
        Mon, 28 Aug 2023 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693234277;
        bh=jD4VlYUlY+oZHcnEYNohEuUlkOxYBChf3b8erligfko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyWkjMRYwpD/+JQu9WW3eC/E7J3M0AloIwVcs0Ge4WsZ9l2Ug1xbq5Fmw/p1N5JBx
         gEyZw8vuaaZGT6wjINFQGII45qSprCxb5CzPG1BqlTAUVxt/N7o0wgHuqVdrtKk1ax
         HsYVFMrouLkdkv8GSbRhEEokYaA/A0jp8K08IntI=
Date:   Mon, 28 Aug 2023 16:51:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, daniel@ffwll.ch, sam@ravnborg.org,
        javierm@redhat.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 8/8] staging/fbtft: Use fb_ops helpers for deferred I/O
Message-ID: <2023082805-gizmo-barrack-9467@gregkh>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-9-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828132131.29295-9-tzimmermann@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 28, 2023 at 03:14:24PM +0200, Thomas Zimmermann wrote:
> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
> the generated functions with an fbdev initializer macro.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
