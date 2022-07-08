Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428A356BEBD
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiGHQWn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiGHQWc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 12:22:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA07B367;
        Fri,  8 Jul 2022 09:22:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s27so22726144pga.13;
        Fri, 08 Jul 2022 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pWV5ymtSkb4oQwKzdRG4xc80jYwd1cDXp5Bm9N4oxeU=;
        b=lgsprlJLenV36x7BzHlsJ6RuYTzhtVWR6c2rZUmjfou1L4nqziCaB9xSIYqWa6nFRX
         0O0d/qM/melc8VHoPLmdli5ac2hMIEKbgfAke97M81ew74zkZi7XzKP77ad7gSJKSAPx
         vcV5YqK1X3GV0NW7sqtn3r0e3RX39ahoP+R3WZBs7KEzaq+3MBKOVvOp1C3LKhNoUs9m
         IzejzQhToJ1z5hJtINpcXYyeiXQWxyBlIWw0jq16atTeqasIjB6dNIoJu3Q3kFbB/xmB
         ddagwenJ3y33ANkELLRLEj673/+95ivPrvKFwCLmOXPgwQGxuCQZS1/oB0yLCB4NO8C3
         VYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pWV5ymtSkb4oQwKzdRG4xc80jYwd1cDXp5Bm9N4oxeU=;
        b=USBufBRUVxeQA6Bom+0kGIoYRbEPKzRzVA5bytek0iE5kbFcrwskqC1hgD2rcc0odw
         fU9HYi3wZqRrb2NaZKQe8gvLC8ExVlXusDCjbLTCEjfoGwQBKn+FfT0guCVEgVIwlcCD
         MBEH+f4JXVgkDRh8u48SuCHE88hMcgTUUHwxMS8/vEWvZA6FMpOzoMICBbDvZuVeqM+s
         G7DR3EXygXl0nl3wBPiN6xw7A1o1InKlbixbJAS7O9HnJDXHCI2BweB1k+dxHOKLEDlJ
         FNfRlcQYD9MGE7wb9dMaZjRmmnirtK2rp5K76g3pMjobG/S9YIwrKnto24PoRFimtDHH
         lcpw==
X-Gm-Message-State: AJIora+NfIzAGAHB74BwUYfcaNqRKXzvKOIA0WMRAgxNM9A6Hq59MMgf
        +/6+vhXmNeENvZMUFIzV2884m2GPFoc/CjT/
X-Google-Smtp-Source: AGRyM1t6XE//mHAuCzTd470VbqGR6fCg+eepzK+JXYrCcmdPEQFGutVuoBUlxtgPhqd4zagmT8qTdg==
X-Received: by 2002:a05:6a00:2404:b0:52a:7fc7:cf57 with SMTP id z4-20020a056a00240400b0052a7fc7cf57mr1210092pfh.11.1657297346212;
        Fri, 08 Jul 2022 09:22:26 -0700 (PDT)
Received: from ?IPV6:2404:f801:10:102:8000::f381? ([2404:f801:8050:3:bf::f381])
        by smtp.gmail.com with ESMTPSA id cd21-20020a056a00421500b0051b32c2a5a7sm28761213pfb.138.2022.07.08.09.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 09:22:14 -0700 (PDT)
Message-ID: <fdcf093c-4a42-ddb7-abc6-c595cb92763e@gmail.com>
Date:   Sat, 9 Jul 2022 00:21:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, bp@suse.de, akpm@linux-foundation.org,
        keescook@chromium.org, pmladek@suse.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
References: <20220707082436.447984-1-ltykernel@gmail.com>
 <YscStPk/IXW9PPmh@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YscStPk/IXW9PPmh@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/8/2022 1:07 AM, Christoph Hellwig wrote:
> Thanks, this looks much better.  I think there is a small problem
> with how default_nareas is set - we need to use 0 as the default
> so that an explicit command line value of 1 works.  Als have you
> checked the interaction with swiotlb_adjust_size in detail?

Yes, the patch was tested in the Hyper-V SEV VM which always calls
swiotlb_adjust_size() to adjust bounce buffer size according to memory
size. It will round up bounce buffer size to the next power of 2 if the 
memory size is not power of 2.
