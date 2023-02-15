Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC046988BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Feb 2023 00:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBOXW7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Feb 2023 18:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBOXW6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Feb 2023 18:22:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF542DC8
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Feb 2023 15:22:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 10so188747ejc.10
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Feb 2023 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tabx9NVVhDi2NL80cED89hxZVqfHcpcD6w5gvEiG26Q=;
        b=Q8cRbK9bsfMvz1Nn6UBM35NtrHJymdIg7nZkemYtGgv/3Q3yDTJhJG+X81qDdYabIf
         xxrtKoM9CiUsnARz3yOk+5K7ZQQZ+AQV90O8Y3pMrOhGvrKc3sTzpKJ1yje35uhNEj4B
         uqqN3W2f/CoTRayN0vR+ZkTzIuArxuwqNE2BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tabx9NVVhDi2NL80cED89hxZVqfHcpcD6w5gvEiG26Q=;
        b=DyR9hn8KZGIsbaO/wVzzwKqVQdJRKp/sBX26OpdZqBJOLQHRgyEGiIGPbZsxVU0vrt
         04ePftS34QuSLmB99heEYjP+KHW5CB8SDvdrbI/vSIYdFJ+J5i4sSymid+PQ4lc7++8A
         yMJV55MG0wZwSRYZufeePYSvSjqadscgZHOgUiQyiB0nxb616WcGQiM/WlJbzxW2h6BC
         E5PxDqR7O8h6CiF58I+t0HXqSAMvKzX5GjjAdYD/SE1EHLSSExhlIZESV9X6qHyjASo5
         iiIhK6n54tgX7LU6VUBlnCSShpWlOYFq/vtcEClNSaouj1D9qSXpNgV2K9O0Wtkyy2Pw
         1FkA==
X-Gm-Message-State: AO0yUKVaQjUIKOsezwD6ht2vBIsQR+oYgreQkwBQczJUumeMFDHEd37a
        9DaLBDaIduEQjODU2wWzM6vCB+v+WiCru0b3slo=
X-Google-Smtp-Source: AK7set/+RrEkgq2XW4JgLLq4P9/Er6kCIkv8iH00MBE++KliT0DJuP5Ub1djTMy3K74mIsEWo+UgrA==
X-Received: by 2002:a17:906:f888:b0:8b1:3b2e:517a with SMTP id lg8-20020a170906f88800b008b13b2e517amr3952746ejb.59.1676503374699;
        Wed, 15 Feb 2023 15:22:54 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id i16-20020a170906699000b00883410a786csm10218725ejr.207.2023.02.15.15.22.52
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:22:53 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id d40so482347eda.8
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Feb 2023 15:22:52 -0800 (PST)
X-Received: by 2002:a50:99cf:0:b0:4ab:4994:e648 with SMTP id
 n15-20020a5099cf000000b004ab4994e648mr2049346edb.5.1676503372641; Wed, 15 Feb
 2023 15:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20230209072220.6836-1-jgross@suse.com> <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
 <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com> <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
 <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
In-Reply-To: <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Feb 2023 15:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
Message-ID: <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
To:     Juergen Gross <jgross@suse.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 15, 2023 at 12:25 AM Juergen Gross <jgross@suse.com> wrote:
>
> The problem arises in case a large mapping is spanning multiple MTRRs,
> even if they define the same caching type (uniform is set to 0 in this
> case).

Oh, I think then you should fix uniform to be 1.

IOW, we should not think "multiple MTRRs" means "non-uniform". Only
"different actual memory types" should mean non-uniformity.

If I remember correctly, there were good reasons to have overlapping
MTRR's. In fact, you can generate a single MTRR that described a
memory ttype that wasn't even contiguous if you had odd memory setups.

Intel definitely defines how overlapping MTRR's work, and "same types
overlaps" is documented as a real thing.

            Linus
