Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE86B753363
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jul 2023 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjGNHn4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jul 2023 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjGNHnz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jul 2023 03:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98998213C
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Jul 2023 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689320588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RV6VmoCSDJlQIGxTSc2C/ilkhOc2GYT+YQNbt5Ygqs=;
        b=aCStSF5wQvr7FnmzgLSldBu89KdtZwYFqQgls4TD1nd5l3MCZ9M+4l4y+pMNkm5LIUuP60
        I+T6In7qG+x4YawYzljk2CcADfcYtceA5h3Ze37G7lJZmYA2WhzDoKXm+1CWFxXKjevPPt
        tY4SGuZjCKem+Qj6VlCyh8FHh3at+8A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-1J5RGh-XM_KyxD-4gB2Zzw-1; Fri, 14 Jul 2023 03:43:07 -0400
X-MC-Unique: 1J5RGh-XM_KyxD-4gB2Zzw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-989249538a1so90887566b.1
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Jul 2023 00:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689320586; x=1691912586;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RV6VmoCSDJlQIGxTSc2C/ilkhOc2GYT+YQNbt5Ygqs=;
        b=Gw85IthH1Vebd0BGzKqZ7K5HS6uPO0NDeqN9YEh4mxVm/qOjkb3c5eh2IHjyVgCquB
         PbObUmOYyzlseAWV2i+84Qr65N3dwR9jyTRXLy4y1opIIrtHz17/8Ijz1smRKtikQT6Y
         /V7j59bgh5FqSGJE6zFH3Gtf1o8q4f6wkx5QvqSouPs8XFxaMqx1+Hq6+6T4WAPMr4MG
         VZUmlHVB/giqunyKFSrLi+ijq79FoFZWHpNefAjw/ToPX9T23DgHuzx6Z65hmcxZmtSt
         zXCwvjlVP/lzV8Eyah3hYg+XlkcCqVnD58j32aOvadNyTBrNFfAOisXICT85JSVlt/9I
         4EAQ==
X-Gm-Message-State: ABy/qLY03Ll/I44a6PyO3Ayfud+kGZswXT4B59Dmd6/wa4sq2B+hUDCH
        dTy5qe1Z+u3uzK1ikGIoNBaRlVxVNWeZh0UYuNGQN28O01tkBqCESC8zgGL9VVxjI1xWrAej7qJ
        1IFWckSteARccr7oW6vH+zDiJ1R7ILauoz9E=
X-Received: by 2002:a17:906:22db:b0:991:b613:9b65 with SMTP id q27-20020a17090622db00b00991b6139b65mr2766722eja.37.1689320586277;
        Fri, 14 Jul 2023 00:43:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkVCdUgKT4CuozT1y45CBxqcp7kgkZtxRkxzueS/PYGMNLQEIkj3Ux6bf9a7KqgPcPlaagDg==
X-Received: by 2002:a17:906:22db:b0:991:b613:9b65 with SMTP id q27-20020a17090622db00b00991b6139b65mr2766691eja.37.1689320585955;
        Fri, 14 Jul 2023 00:43:05 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id d20-20020a170906371400b0098e2eaec395sm5074876ejc.130.2023.07.14.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:43:05 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
Date:   Fri, 14 Jul 2023 09:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
In-Reply-To: <20230713205326.5f960907@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 14/07/2023 05.53, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>> usage.
>>
>> Get an extra ref count of a page after allocation, so after upper
>> layers put the page, it's still referenced by the pool. We can reuse
>> it as RX buffer without alloc a new page.
> 
> Please use the real page_pool API from include/net/page_pool.h
> We've moved past every driver reinventing the wheel, sorry.

+1

Quoting[1]: Documentation/networking/page_pool.rst

  Basic use involves replacing alloc_pages() calls with the 
page_pool_alloc_pages() call.
  Drivers should use page_pool_dev_alloc_pages() replacing 
dev_alloc_pages().


[1] https://kernel.org/doc/html/latest/networking/page_pool.html

