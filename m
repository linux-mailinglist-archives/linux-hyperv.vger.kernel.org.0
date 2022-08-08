Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E4C58CDB7
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiHHSh1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHHSh1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:37:27 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA3EDEE
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=i0y6RSQK7dE3A6Y/eYZg4QjyeroqpJKUhXu6rdO6Qo4=;
        b=GfTxWZlVCPYtW8oNroCmmebJL5AFtXwNVBNy0ZjSv4JyMp6eqSLzDTKAJCXULXmuDIyV7FHzuEOOM
         76r1CkYC+LRKwM6LRnDBGAAuQfoiOpZMNPUc5j7Mt6rrHkK6tSiyyT+B18FYxSYsCkizxx8QDRRLUe
         hs+tLPByYjCNkKYPS+p7AMU2U+uJZkbWhUjt9Ia5+OvRlGLb4X1NZmyAKn/uSuwxGdVkzkYpi4TaJZ
         jecVpkRIj5CmFrRS1qKACrLgb3eIx5C9BfeVeimODedH+Dz/hcdchHq+x1b04B4hRZOxiQ9z6mNM6V
         4HHkRpO26nAiA6T7z9+YSQzVbHTxHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=i0y6RSQK7dE3A6Y/eYZg4QjyeroqpJKUhXu6rdO6Qo4=;
        b=tawh23rV8gu8jKqNH/F+PQjY0phHkkqLNbhyRaeMeid8e4h303EMqugcfZwDtgW8U21GPOT+IZ8FF
         AHUcMwFAQ==
X-HalOne-Cookie: 03e7d3fadb5e1d8e6e2175ae13c72f7a820641fa
X-HalOne-ID: 24432e59-1749-11ed-8244-d0431ea8bb10
Received: from mailproxy4.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 24432e59-1749-11ed-8244-d0431ea8bb10;
        Mon, 08 Aug 2022 18:37:23 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:37:21 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 01/14] iosys-map: Add IOSYS_MAP_INIT_VADDR_IOMEM()
Message-ID: <YvFX4eSZ8/PU4+RL@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-2-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 08, 2022 at 02:53:53PM +0200, Thomas Zimmermann wrote:
> Add IOSYS_MAP_INIT_VADDR_IOMEM() for static init of variables of type
> struct iosys_map.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  include/linux/iosys-map.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
> index a533cae189d7..cb71aa616bd3 100644
> --- a/include/linux/iosys-map.h
> +++ b/include/linux/iosys-map.h
> @@ -46,10 +46,13 @@
>   *
>   *	iosys_map_set_vaddr(&map, 0xdeadbeaf);
>   *
> - * To set an address in I/O memory, use iosys_map_set_vaddr_iomem().
> + * To set an address in I/O memory, use IOSYS_MAP_INIT_VADDR_IOMEM() or
> + * iosys_map_set_vaddr_iomem().
>   *
>   * .. code-block:: c
>   *
> + *	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(0xdeadbeaf);
> + *
>   *	iosys_map_set_vaddr_iomem(&map, 0xdeadbeaf);
>   *
>   * Instances of struct iosys_map do not have to be cleaned up, but
> @@ -121,6 +124,16 @@ struct iosys_map {
>  		.is_iomem = false,	\
>  	}
>  
> +/**
> + * IOSYS_MAP_INIT_VADDR_IOMEM - Initializes struct iosys_map to an address in I/O memory
> + * @vaddr_iomem_:	An I/O-memory address
> + */
> +#define IOSYS_MAP_INIT_VADDR_IOMEM(vaddr_iomem_)	\
> +	{						\
> +		.vaddr_iomem = (vaddr_iomem_),		\
> +		.is_iomem = true,			\
> +	}
> +
>  /**
>   * IOSYS_MAP_INIT_OFFSET - Initializes struct iosys_map from another iosys_map
>   * @map_:	The dma-buf mapping structure to copy from
> -- 
> 2.37.1
