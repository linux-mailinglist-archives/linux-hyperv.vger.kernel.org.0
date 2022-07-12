Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6557194C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiGLL7n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiGLL7U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11D454F649
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7QIDSxZFUYXNY6pVprVvC57ag3whDjnsY/JfggEm9w=;
        b=HqSSfhWOzVKev4L9AZJxjvqd3BUkm/Qwt1ejxbxu5RkF+Byb7aRLlLyZbngFNjHPOwFjFg
        dS8/nTjqmjfjTkIsluet+kB4qESqRk7vsQl42Q0F1vOImRocYkBFUnyHPUMz2YxdRhrulh
        wb4Brcx+0103yQ/dDKNLREy61EIelH8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-o7x0p41ePAav_3M7S8a6iw-1; Tue, 12 Jul 2022 07:58:53 -0400
X-MC-Unique: o7x0p41ePAav_3M7S8a6iw-1
Received: by mail-qv1-f69.google.com with SMTP id lb15-20020a056214318f00b00473726845c8so1650561qvb.8
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=U7QIDSxZFUYXNY6pVprVvC57ag3whDjnsY/JfggEm9w=;
        b=n2El+lvr7uatPX0v6U0tTu39qkNe1S6vmmMAIg8k1wsO1woirF3Kko0PS84eqbMCuI
         r5xB0PSBz9VVOzXMD6B4SpbmuQ52U7cSDlj6STe/1+5hBZhDpX+wd+/MO/QuMFaLFz39
         XsV6LeEnwW/rCQmovO4oWaL/G1I9h6IK5S9h0ON0z70UnzmPE3A7ZvOpyMftvDjCvtc2
         PnJO1/VaYxlPU17O/WctFr0b8oGQt+8reQca/FYb451u2CiYmlY2XsqCQ9fk0NjF6dWs
         ApRy3uegQk7Pm8sL+YylZUIgoOCyYcegJV1EIblhIJl2kkQv0pmAyvh2ABHg7c7BmH6m
         noew==
X-Gm-Message-State: AJIora+OFraxEEvon0Gdpj1AD24SJOv+nJ+BZPf47y83BmZAygmXltya
        U7GTV/uf9vdjYfMer5J7ia0tJJWYYfuv0k0THN3TccsLQu+7LfGo+ny0sxrYGlUQJbawu8Ddfg8
        1DyInJV85EUdrGejKeF60eWaq
X-Received: by 2002:a05:622a:1482:b0:31e:9c01:ed76 with SMTP id t2-20020a05622a148200b0031e9c01ed76mr17567955qtx.547.1657627132202;
        Tue, 12 Jul 2022 04:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tksyjUqV7B20gdvMOv4LZE1LenmZxesRu/qi13zSNQNrALL51hn8UahTbmHqtcAR2R0Kuekg==
X-Received: by 2002:a05:622a:1482:b0:31e:9c01:ed76 with SMTP id t2-20020a05622a148200b0031e9c01ed76mr17567880qtx.547.1657627130522;
        Tue, 12 Jul 2022 04:58:50 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a415200b006b5905999easm4619740qko.121.2022.07.12.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:58:49 -0700 (PDT)
Message-ID: <0a17abb673be4042ab06eb999fe5676519b4101c.camel@redhat.com>
Subject: Re: [PATCH v3 20/25] KVM: x86: VMX: Replace some Intel model
 numbers with mnemonics
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:58:46 +0300
In-Reply-To: <20220708144223.610080-21-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-21-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> Intel processor code names are more familiar to many readers than
> their decimal model numbers.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index eca6875d6732..2dff5b94c535 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2580,11 +2580,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>          */
>         if (boot_cpu_data.x86 == 0x6) {
>                 switch (boot_cpu_data.x86_model) {
> -               case 26: /* AAK155 */
> -               case 30: /* AAP115 */
> -               case 37: /* AAT100 */
> -               case 44: /* BC86,AAY89,BD102 */
> -               case 46: /* BA97 */
> +               case INTEL_FAM6_NEHALEM_EP:     /* AAK155 */
> +               case INTEL_FAM6_NEHALEM:        /* AAP115 */
> +               case INTEL_FAM6_WESTMERE:       /* AAT100 */
> +               case INTEL_FAM6_WESTMERE_EP:    /* BC86,AAY89,BD102 */
> +               case INTEL_FAM6_NEHALEM_EX:     /* BA97 */
>                         _vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
>                         _vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
>                         pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "

I cross checked the values, seems correct.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

