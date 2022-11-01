Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130B614D2A
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKAOz2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKAOz0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 10:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E62DE2
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Nov 2022 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667314466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpfQYVzMIcuMXx56DkvqTXydEG0Wdlj350I7KRytfvw=;
        b=hyqrnk5KOZGGUOP7rDSltT+yMb+hYiL1dY9CyEmhxtaVUqUZNSnkFQus+ClkvCYI+UoN2z
        aZZm4wOwhBbbTKOsD+91JMzt2I6eTb/USCsgOC1Y+KAsVeoRJ5Lay4fYK5Ej9JT8YCKvEa
        TVS7AJ4cxmhKZ7LsD/E6obuSAFcTAiA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-MUs2fEArNGiH7q24ahUrfg-1; Tue, 01 Nov 2022 10:54:25 -0400
X-MC-Unique: MUs2fEArNGiH7q24ahUrfg-1
Received: by mail-ej1-f69.google.com with SMTP id he6-20020a1709073d8600b0078e20190301so8123383ejc.22
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Nov 2022 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpfQYVzMIcuMXx56DkvqTXydEG0Wdlj350I7KRytfvw=;
        b=RpbLPDI5YkNcyygigohhOB/gswvvBk379XEzGoAOEJAbpmIVl4WSzrCdrKaxT//QUX
         Glwpih0WfYCFcPCKHrZsMZXfx2K2NAs2vbLnvgdojhRWmLwBOdcgtkaQrL4X4GrpiiNG
         b3FcZjPvTV6sRf/wJisnhuPLHtu8F9zqWtOohpyI5uSe2CTk9ztzHd45v0zJ88CEQ09S
         PtWsRPF8if3meynUUZ0DNt5Acy5kzZZQn+G7qUEcjzRdw0cHNATTa+Zfd7BSVYk4DujH
         GHjkof7KKfkw0KrOI8WhuW6SWQ4wv+D4ZPJatwxrz723zsAuVbO5KDw1lVftvuwNaIrf
         wNiQ==
X-Gm-Message-State: ACrzQf0M4ySD8mJvJp8cuJi5+R2A+dw59nCMnMezhPrz8fGVlWslfeEM
        N12LPEt7AFz/po7WCg9CqaDLtFGSiQ+RxqmD90WCRzqIM1Vrwt3lIivLybd1B9/gSyn3qRs5JeH
        IcW23L0Ds/xSrBkQv1FKGTNlp
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id sc36-20020a1709078a2400b00795bb7d643bmr19113931ejc.115.1667314464041;
        Tue, 01 Nov 2022 07:54:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cO4rk8NeV9RvMCaBS52ImLLAf4ZLqcdpiLZqjgPxz3IJI9NfZXhSLsdW9KGQGq3mQMXBZDg==
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id sc36-20020a1709078a2400b00795bb7d643bmr19113910ejc.115.1667314463791;
        Tue, 01 Nov 2022 07:54:23 -0700 (PDT)
Received: from ovpn-194-149.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m23-20020a170906849700b0079e11b8e891sm4207005ejx.125.2022.11.01.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:54:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/46] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <87zgdcs65g.fsf@ovpn-194-149.brq.redhat.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <Y1m0ef+LdcAW0Bzh@google.com> <Y1m1Jnpw5betG8CG@google.com>
 <87zgdcs65g.fsf@ovpn-194-149.brq.redhat.com>
Date:   Tue, 01 Nov 2022 15:54:21 +0100
Message-ID: <87h6zisp2a.fsf@ovpn-194-149.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

>
> Paolo,
>
> do you want to follow this path or do you expect the full 'v13' from me? 

v13 it is :-) I've added all the tags and addressed the remaining
feedback (a typo fixed + a comment added).

-- 
Vitaly

