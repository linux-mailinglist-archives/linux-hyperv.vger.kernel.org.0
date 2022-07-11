Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B16560431
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jun 2022 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiF2PGx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jun 2022 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiF2PGn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jun 2022 11:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EC6A18B03
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656515201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNBrmWnN3XnulCkQsAu4oIaBrmhBegkKO8NaBiEN1js=;
        b=Si77TsV17CpV6RnUnjcZT9SlcjQY8BKAeK8YMAYcdcSiuOZNwNseQl0wJsTP7s+n8/4HU7
        W9jEi5sEvH4gc4mOCUIOjmDA4+lrq86RawRQP4XR0s4zASQY4HxMi37TCl/Z4GU03XwL4C
        siH1HKnOXN+8vkG1AYEXKouBcy3OdJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-UpEHCDagNiysaPRXBBCE7Q-1; Wed, 29 Jun 2022 11:06:37 -0400
X-MC-Unique: UpEHCDagNiysaPRXBBCE7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38287101A588;
        Wed, 29 Jun 2022 15:06:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5DA40EC002;
        Wed, 29 Jun 2022 15:06:35 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/28] KVM: VMX: Define VMCS-to-EVMCS conversion for the new fields
Date:   Wed, 29 Jun 2022 17:06:01 +0200
Message-Id: <20220629150625.238286-5-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-1-vkuznets@redhat.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Enlightened VMCS v1 definition was updated with new fields, support
them in KVM by defining VMCS-to-EVMCS conversion.

Note: SSP, CET and Guest LBR features are not supported by KVM yet and
the corresponding fields are not defined in 'enum vmcs_field', leave
them commented out for now.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 6a61b1ae7942..8bea5dea0341 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -28,6 +28,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
 	EVMCS1_FIELD(HOST_IA32_EFER, host_ia32_efer,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_IA32_PERF_GLOBAL_CTRL, host_ia32_perf_global_ctrl,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
 	EVMCS1_FIELD(HOST_CR0, host_cr0,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
 	EVMCS1_FIELD(HOST_CR3, host_cr3,
@@ -78,6 +80,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
 	EVMCS1_FIELD(GUEST_IA32_EFER, guest_ia32_efer,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_IA32_PERF_GLOBAL_CTRL, guest_ia32_perf_global_ctrl,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
 	EVMCS1_FIELD(GUEST_PDPTR0, guest_pdptr0,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
 	EVMCS1_FIELD(GUEST_PDPTR1, guest_pdptr1,
@@ -126,6 +130,28 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
 	EVMCS1_FIELD(XSS_EXIT_BITMAP, xss_exit_bitmap,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+	EVMCS1_FIELD(ENCLS_EXITING_BITMAP, encls_exiting_bitmap,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+	EVMCS1_FIELD(TSC_MULTIPLIER, tsc_multiplier,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+	/*
+	 * Not used by KVM:
+	 *
+	 * EVMCS1_FIELD(0x00006828, guest_ia32_s_cet,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	 * EVMCS1_FIELD(0x0000682A, guest_ssp,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC),
+	 * EVMCS1_FIELD(0x0000682C, guest_ia32_int_ssp_table_addr,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	 * EVMCS1_FIELD(0x00002816, guest_ia32_lbr_ctl,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	 * EVMCS1_FIELD(0x00006C18, host_ia32_s_cet,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	 * EVMCS1_FIELD(0x00006C1A, host_ssp,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	 * EVMCS1_FIELD(0x00006C1C, host_ia32_int_ssp_table_addr,
+	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	 */
 
 	/* 64 bit read only */
 	EVMCS1_FIELD(GUEST_PHYSICAL_ADDRESS, guest_physical_address,
-- 
2.35.3

