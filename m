Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A454C4431
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiBYMEP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiBYMEP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 07:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A30B1B84E9
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Feb 2022 04:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645790622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=MYgCpWMVp043QuupWkbY+nAE/rfXfOeJgGb2+LuektdZAQNnjsB0SSgY1tJxk1R8csErku
        cA3bC/Uo4dF30FkSIctWOpXkxB1+nU9DHKkvB+JCYiWbRCo84f2A9/9ZCnegalFIS++Gal
        NWYz5WICTWx4vDfP/hU+W8ra+szE7JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-J0n2rnBTO3aOgL-ZGXZvwA-1; Fri, 25 Feb 2022 07:03:37 -0500
X-MC-Unique: J0n2rnBTO3aOgL-ZGXZvwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 930CB801AAD;
        Fri, 25 Feb 2022 12:03:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41EC11038ADB;
        Fri, 25 Feb 2022 12:03:27 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, kvm@vger.kernel.org, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, Andrea.Parri@microsoft.com,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH] x86/kvmclock: Fix Hyper-V Isolated VM's boot issue when vCPUs > 64
Date:   Fri, 25 Feb 2022 07:02:44 -0500
Message-Id: <20220225120243.2387649-1-pbonzini@redhat.com>
In-Reply-To: 20220225084600.17817-1-decui@microsoft.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Queued, thanks.

Paolo


