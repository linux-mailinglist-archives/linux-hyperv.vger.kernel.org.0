Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0FB136CA6
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2020 13:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgAJMAH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Jan 2020 07:00:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727939AbgAJMAF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Jan 2020 07:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578657604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+s42rGCNweegI3ua1aTVb4LJtn2yQPTTMH9TXAr+EXc=;
        b=IZ99LSWZDFqKu38cbyNKO9rkwdJ7YaVLpploJGtUMBDljWBXove5H72C1VZ9KuZEeOkARq
        MvY1XlXo6chtgw97AxOrC0BAukM546gOhmZgne1YxKU7m9O+R4RDvY8bTgTIXx0Ieq45wU
        2Fmhi48n6khJGsIPCKHKAkTxSW98IEI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-hrZJVYchPCGQK0ez-kSFoA-1; Fri, 10 Jan 2020 07:00:03 -0500
X-MC-Unique: hrZJVYchPCGQK0ez-kSFoA-1
Received: by mail-wr1-f71.google.com with SMTP id o6so788485wrp.8
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jan 2020 04:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+s42rGCNweegI3ua1aTVb4LJtn2yQPTTMH9TXAr+EXc=;
        b=FACGJpZCO2CjWWtLLBVKzexihYU15J3mDrSZY5rntFVM336OsQZr/NB14MBgLNTJ2e
         WwGe8XBACRhkGLkCmX88oHIAPSikZ7EuXVe+UBddY1X2QRlmInivi4FU/1lkG1dPUtRL
         kwkToj5STuq7Kz1z3fRL5hQRKMjUeH27QCSCD4NRCCuuggUgnqLxOuDPY6jHAHUrPcVF
         AVCciTvIn7yGf/GyGfvRFEr13Ib3h7vxCb3vgakHvMv/mXvPVpdI1uemT/mNO6hF+4dr
         vX18K2vY7Jj5U2YkdoaMDC926sYxSRVAEJ/FmrxlgdHoxPicW68Yx4rL+t/nY3H9EF7k
         Fkqw==
X-Gm-Message-State: APjAAAXERcmg5zeRJAe7YwvoA5jhqjSe3jEpsH6pqGZeBgrpIQ6FJDmk
        vD7oKdqb3MOa+iFi3/zQ7m4etlf4mvqFRknOTUp8XiMc0K3SSFa2XaVd4LAvBl/RTLwuy3ccu/t
        0PeD9zbO/4tNOpiAD/kpNp7xz
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3210024wrp.236.1578657601318;
        Fri, 10 Jan 2020 04:00:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5+0kKs8+INAcy7JLlyzVUvfEzD/INVvB9zh9aSkzLQOAVTQcSdysqcYYLDz0BpOrluviy5g==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3209989wrp.236.1578657601000;
        Fri, 10 Jan 2020 04:00:01 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c5sm2094046wmb.9.2020.01.10.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 04:00:00 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenzhou10@huawei.com, tglx@linutronix.de, mingo@redhat.com
Subject: Re: [PATCH] x86/hyper-v: remove unnecessary conversions to bool
In-Reply-To: <20200110072047.85398-1-chenzhou10@huawei.com>
References: <20200110072047.85398-1-chenzhou10@huawei.com>
Date:   Fri, 10 Jan 2020 12:59:59 +0100
Message-ID: <875zhjr074.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Chen Zhou <chenzhou10@huawei.com> writes:

> The conversions to bool are not needed, remove these.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 40e0e32..3112cf6 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -133,7 +133,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
>  
>  ipi_mask_ex_done:
>  	local_irq_restore(flags);
> -	return ((ret == 0) ? true : false);
> +	return ret == 0;
>  }
>  
>  static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> @@ -186,7 +186,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
>  
>  	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
>  				     ipi_arg.cpu_mask);
> -	return ((ret == 0) ? true : false);
> +	return ret == 0;
>  
>  do_ex_hypercall:
>  	return __send_ipi_mask_ex(mask, vector);

I'd suggest we get rid of bool functions completely instead, something
like (untested):

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 40e0e322161d..440bda338763 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -97,16 +97,16 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 /*
  * IPI implementation on Hyper-V.
  */
-static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
+static u16 __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 {
 	struct hv_send_ipi_ex **arg;
 	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
 	int nr_bank = 0;
-	int ret = 1;
+	u16 ret;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		return false;
+		return U16_MAX;
 
 	local_irq_save(flags);
 	arg = (struct hv_send_ipi_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -129,29 +129,28 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
 
 	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
-			      ipi_arg, NULL);
+				  ipi_arg, NULL);
 
 ipi_mask_ex_done:
 	local_irq_restore(flags);
-	return ((ret == 0) ? true : false);
+	return ret;
 }
 
-static bool __send_ipi_mask(const struct cpumask *mask, int vector)
+static u16 __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
 	struct hv_send_ipi ipi_arg;
-	int ret = 1;
 
 	trace_hyperv_send_ipi_mask(mask, vector);
 
 	if (cpumask_empty(mask))
-		return true;
+		return 0;
 
 	if (!hv_hypercall_pg)
-		return false;
+		return U16_MAX;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
-		return false;
+		return U16_MAX;
 
 	/*
 	 * From the supplied CPU set we need to figure out if we can get away
@@ -172,7 +171,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	for_each_cpu(cur_cpu, mask) {
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
 		if (vcpu == VP_INVAL)
-			return false;
+			return U16_MAX;
 
 		/*
 		 * This particular version of the IPI hypercall can
@@ -184,41 +183,40 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
 	}
 
-	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
-				     ipi_arg.cpu_mask);
-	return ((ret == 0) ? true : false);
+	return (u16)hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
+					   ipi_arg.cpu_mask);
 
 do_ex_hypercall:
 	return __send_ipi_mask_ex(mask, vector);
 }
 
-static bool __send_ipi_one(int cpu, int vector)
+static u16 __send_ipi_one(int cpu, int vector)
 {
 	int vp = hv_cpu_number_to_vp_number(cpu);
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
 	if (!hv_hypercall_pg || (vp == VP_INVAL))
-		return false;
+		return U16_MAX;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
-		return false;
+		return U16_MAX;
 
 	if (vp >= 64)
 		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
 
-	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
+	return (u16)hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
 }
 
 static void hv_send_ipi(int cpu, int vector)
 {
-	if (!__send_ipi_one(cpu, vector))
+	if (__send_ipi_one(cpu, vector))
 		orig_apic.send_IPI(cpu, vector);
 }
 
 static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
 {
-	if (!__send_ipi_mask(mask, vector))
+	if (__send_ipi_mask(mask, vector))
 		orig_apic.send_IPI_mask(mask, vector);
 }
 
@@ -231,7 +229,7 @@ static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 	cpumask_copy(&new_mask, mask);
 	cpumask_clear_cpu(this_cpu, &new_mask);
 	local_mask = &new_mask;
-	if (!__send_ipi_mask(local_mask, vector))
+	if (__send_ipi_mask(local_mask, vector))
 		orig_apic.send_IPI_mask_allbutself(mask, vector);
 }
 
@@ -242,13 +240,13 @@ static void hv_send_ipi_allbutself(int vector)
 
 static void hv_send_ipi_all(int vector)
 {
-	if (!__send_ipi_mask(cpu_online_mask, vector))
+	if (__send_ipi_mask(cpu_online_mask, vector))
 		orig_apic.send_IPI_all(vector);
 }
 
 static void hv_send_ipi_self(int vector)
 {
-	if (!__send_ipi_one(smp_processor_id(), vector))
+	if (__send_ipi_one(smp_processor_id(), vector))
 		orig_apic.send_IPI_self(vector);
 }

-- 
Vitaly

