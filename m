Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC89575278
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Jul 2022 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiGNQKI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Jul 2022 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiGNQKH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Jul 2022 12:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A87BC53D0C
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Jul 2022 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657815005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=Apy3IlU2uqzNCQkS4jWNkLnnHymqPMtXY94p2lkWmQ/lpxymbdxmrS67ZJonk2+7hDfBj4
        AdDO5EWiY9jS2yeFeIMbfJRklVWJkmJpaC3pdx5c4xwedUCQImiqD7Ecg9++Lj0a7VyXpp
        LzRldDu46Aa7krrrzH2nqq02hJWH9eI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-Wt1mT6CwNwG-THLP9JeKTg-1; Thu, 14 Jul 2022 12:10:00 -0400
X-MC-Unique: Wt1mT6CwNwG-THLP9JeKTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FBC63C0D855;
        Thu, 14 Jul 2022 16:10:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFE20492C3B;
        Thu, 14 Jul 2022 16:09:59 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Fully initialize 'struct kvm_lapic_irq' in kvm_pv_kick_cpu_op()
Date:   Thu, 14 Jul 2022 12:09:55 -0400
Message-Id: <20220714160955.1430206-1-pbonzini@redhat.com>
In-Reply-To: <20220708125147.593975-1-vkuznets@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Queued, thanks.

Paolo


