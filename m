Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8658CDE8
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbiHHSoe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiHHSoU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:44:20 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF224A441
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=ZTp6SIDLt5GT3+bYAdxWFxhygxOBr/A7Riii2XrJfsc=;
        b=qhGpcxdb5iTbEBtvZPVLEA6ZpqKHR8yu4ZU8RMLVyULUlpuViXjv5sLW9s8EbpNBeuxkp3vOy+A3i
         ro3rWUTX2ntUy3aMfpdUg7VFehlTK83iDTfAA9xgwWrwwYQatToe5Q6Nn0lnkYJ5ebYDUbBF8Z9Ik2
         pWh1qlFKhJKTIgYAHepzyWGLCkYI5XJSk7f9rnow+JEsAoXU0B+yLxaoCQgdaBOx7CYyzjmoMupNxH
         ptVn1RYFMy9LM272K9Ab9qzU8/wMXvLpa+ASdikJ/bk75JFfibKV0nrg1gN2Aauj5kNT/2KrXiZg5n
         FLj+eSxKJHb+Y9hVxJs0wDH1aRHj5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=ZTp6SIDLt5GT3+bYAdxWFxhygxOBr/A7Riii2XrJfsc=;
        b=krHftYRNaUIwUi2jPUvODBthBMPhm1UnlHVDq/my2tEemJ0SoWJXWf5GYoaSsokq99Zl2pUloaXyx
         6/KigL3CA==
X-HalOne-Cookie: eb00fd88576e255c300373dd3168e6e64109d575
X-HalOne-ID: 02a222c7-174a-11ed-a91b-d0431ea8a290
Received: from mailproxy3.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 02a222c7-174a-11ed-a91b-d0431ea8a290;
        Mon, 08 Aug 2022 18:43:36 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:43:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 03/14] drm/format-helper: Merge drm_fb_memcpy() and
 drm_fb_memcpy_toio()
Message-ID: <YvFZVlkfUFowPeu3@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-4-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On Mon, Aug 08, 2022 at 02:53:55PM +0200, Thomas Zimmermann wrote:
> Merge drm_fb_memcpy() and drm_fb_memcpy_toio() into a drm_fb_memcpy()
> that uses struct iosys_map for buffers. The new function also supports
> multi-plane color formats. Convert all users of the original helpers.
> 
> v2:
> 	* rebase onto refactored mgag200
> 	* use drm_formap_info_bpp() (Sam)
> 	* do static init in hyperv and mgag200 (Sam)
> 	* update documentation (Sam)
> 	* add TODO on vaddr location (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
