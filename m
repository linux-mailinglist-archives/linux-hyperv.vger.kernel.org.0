Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9918040E
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2020 17:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCJQz6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Mar 2020 12:55:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726442AbgCJQz4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Mar 2020 12:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583859355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3qfwe4RA12qs3/yjv/r1NIyEKt8LSMmQD8gHLGHKf8=;
        b=g2zFQ8HuBdF2SIyYtzyE1WiYP/nioJno1Al8RuZr3wOk9TYbdRv+uQYPl2feQ8EuoyQqLt
        ibDF1Vugl/8YQcsykd1uMC7sCAK03r+mby5Vr1L+4iDYX05zstOzP+gDju0KUbyWsqqR72
        m7XBxHcqslBP0LPCdW2jU7PZZ2XdiMY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-ZFMMDpNDOy-Yr9106pN2Jw-1; Tue, 10 Mar 2020 12:55:52 -0400
X-MC-Unique: ZFMMDpNDOy-Yr9106pN2Jw-1
Received: by mail-wm1-f71.google.com with SMTP id a23so620561wmm.8
        for <linux-hyperv@vger.kernel.org>; Tue, 10 Mar 2020 09:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j3qfwe4RA12qs3/yjv/r1NIyEKt8LSMmQD8gHLGHKf8=;
        b=ksfHlFrtvLR/vwXuo0kFxRQBoLipOjucR1d9pGO3RiXzO4ou8yOIblKwZkm8a/KJrN
         m+HStzulCjK6El8b/96wqMgfmiv8K9tTjN+eg9sseuNbJFGhBA2c+MA4WOhlAcLbwfhe
         2xycvrl/0o0eQhd1NkcmWognKnCHON3M0Zd+k4C1ZgmkWOQI3+ja3lGwCprNGHlYGUm8
         G9VruLdrNimxPNKLIL9Ic78ZzwEJU0h8cq9W+GBu5V8/NC/pcxkg64Z+b6vmdHpxxk2Z
         8vhku1euuomJuz/e4IRGfmIIS96SDPRkE1wkEcnAQjMKiRyaF6jjnCT+JtI2t4nLchGP
         6fmw==
X-Gm-Message-State: ANhLgQ3DMnLCrSgk6PjXOGIDt3ozJLACWH6NhfTQMfVkDhN+u/WeveTT
        ckVBdwCO6Zqi8p0mglcncCtwBFHsklWwkv/kVqxrj7kByNfO2JUqrUacP8nVPYMGm84oX5NpfW2
        edjhM0sZChl7qWi183vcxdhtn
X-Received: by 2002:a5d:5089:: with SMTP id a9mr28974809wrt.187.1583859350876;
        Tue, 10 Mar 2020 09:55:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuPaKS4BThnZhT5XzCWWQoBNzywQ/daG1qZmeVnIS8G8VRLR3EYLcfUJvusx+p1DhMq1vmmzw==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr28974791wrt.187.1583859350694;
        Tue, 10 Mar 2020 09:55:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b5sm24992416wrj.1.2020.03.10.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 09:55:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v4 1/5] x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
In-Reply-To: <20200309182017.3559534-2-arilou@gmail.com>
References: <20200309182017.3559534-1-arilou@gmail.com> <20200309182017.3559534-2-arilou@gmail.com>
Date:   Tue, 10 Mar 2020 17:55:49 +0100
Message-ID: <87k13sb14a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4b95f9a31a2f..7acfd6a2569a 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -189,6 +189,7 @@ struct kvm_hyperv_exit {
>  #define KVM_EXIT_HYPERV_SYNIC          1
>  #define KVM_EXIT_HYPERV_HCALL          2
>  	__u32 type;
> +	__u32 pad;
>  	union {
>  		struct {
>  			__u32 msr;

Sorry if I missed something but I think the suggestion was to pad this
'msr' too (in case we're aiming at making padding explicit for the whole
structure). Or is there any reason to not do that?

Also, I just noticed that we have a copy of this definition in
Documentation/virt/kvm/api.rst - it will need to be updated (and sorry
for not noticing it earlier).

-- 
Vitaly

