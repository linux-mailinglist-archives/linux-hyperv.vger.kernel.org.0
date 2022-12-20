Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D583651CE8
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLTJLX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLTJLW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8737661
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671527437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nkva43Ev6FmONs/91WyhlWJwflJzPv43uZcJFYvlalU=;
        b=JzBWdQOszQ7DlHvTb0wSn8Tf1GCTLLK10xId6uF2YQIQ914Kxxi9ub5Cam8pK0D55BVThL
        g4zTUdGjkSvhx77Fjh4k3+fkswYcSzF01TsVZK4g2GIY/ATw8im/zjRR7F5EGAVOeyEOTs
        ncE15wSmZIKhfZaj7UBYA8UJCr4TU/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-487-LbmivOBVPfqTByobIReOyQ-1; Tue, 20 Dec 2022 04:10:36 -0500
X-MC-Unique: LbmivOBVPfqTByobIReOyQ-1
Received: by mail-wm1-f72.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso6283530wmh.2
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkva43Ev6FmONs/91WyhlWJwflJzPv43uZcJFYvlalU=;
        b=FxkHL17oHEOEUM280K6hBVxyZBDayLG9YL9AEb/2mdBi5TyQiOg4U0TCgBLqTeqTJy
         jrl+uaDR/hWqeEUcKcUltFJV5WjZU8zmP7jIyPPxlFEn4EsnaDYpOTsdfxnDlaqTpBUU
         7J7r8nf9nmyxQt87xT+tsnQbMW+Db8tqc/Bm9cNgZa3XLIDLxrAjgYgupquGmljtyBYH
         5AJ9ZOzkDjr1KeX2XCcZWCKRaxhTGXpUMaPp9R5kqDHg+DSjOy4w1LF20Yy/HFbckvKM
         skx2OIhah5nYa1QNpvWFz3sPw1fMdOQ1hlbWkK+DrpWRRfKpZ5Q+LcfdYb60tlZjUDsX
         j74A==
X-Gm-Message-State: AFqh2krqgEwbM+I6bMjiDN5HchKamzCDBBJwY4ZmWYXtSWnH8lhgC/xQ
        APXni3IlAk91fAnUPG07zVn1v9cKhsVKBn/2ZrTclPK4fVcIp2Rcyp/a1RgMRcWtQ/JIZyFSYya
        Oeevlkf8YFbKcSTZJMPiQjqAk
X-Received: by 2002:a5d:624a:0:b0:242:19b3:67 with SMTP id m10-20020a5d624a000000b0024219b30067mr748880wrv.37.1671527435451;
        Tue, 20 Dec 2022 01:10:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZ4T3pjgbBye4AD0pnUB9As/CnLPdlMjMDQrxm4f9mLfnMBPQihgpuK1r6jSAdZ8wsH7ZV9g==
X-Received: by 2002:a5d:624a:0:b0:242:19b3:67 with SMTP id m10-20020a5d624a000000b0024219b30067mr748861wrv.37.1671527435215;
        Tue, 20 Dec 2022 01:10:35 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b00241fea203b6sm12177113wry.87.2022.12.20.01.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:10:34 -0800 (PST)
Message-ID: <1ba311d8-efe5-c3f0-761e-1b5695dd5ba2@redhat.com>
Date:   Tue, 20 Dec 2022 10:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/18] fbcon: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:04, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

