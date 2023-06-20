Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4D7371A4
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjFTQbn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjFTQbf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 12:31:35 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F819AB;
        Tue, 20 Jun 2023 09:30:54 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KFQaEh017220;
        Tue, 20 Jun 2023 16:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=Wq0tNAZYntMOwujjPXOicpBp9fXP+Uj7oYrHjROJbZA=;
 b=M+xfl8GZ6kqZ1CiDzA9X4UIph7j8Uxk6Zk8O01krfcaIRWFNJug8wkFrqz3VGFySwXya
 1Xk55oPZl9kiBmZShhESmyFrg0lc+brEJpdfF+dLLRDmCDyq/nx5YTaKjX0OV3r4lYC7
 MIBtmOJSNz4ns3EIlzL3a7oZp4aWDTOMu+knYFslil3rQbLnqc96PMraSGJeJa7VRE1H
 YmjPkI97ewmuBuxLOd1zXrNKZFnIQqF0/Rcgql9LdSnHw9EsHQMEpaoIr2rABytBDo4p
 q7vDTnFAz2SfEK3+Ff7iW5H3E2HEE04CQMsPUXDChNXXMiyufzK11zizYoWdBnsNvC0O IA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rberk8jh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 16:27:49 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id EB7DD12B43;
        Tue, 20 Jun 2023 16:27:47 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id A16C180871B;
        Tue, 20 Jun 2023 16:27:43 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:27:41 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, steve.wahl@hpe.com,
        dimitri.sivanich@hpe.com, russ.anderson@hpe.com,
        dvhart@infradead.org, andy@infradead.org, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, seanjc@google.com, jiangshanlai@gmail.com,
        jgg@ziepe.ca, yangtiezhu@loongson.cn
Subject: Re: [PATCH 1/3] x86/vector: Rename send_cleanup_vector() to
 vector_schedule_cleanup()
Message-ID: <ZJHTYUrKA/mclxRZ@swahl-home.5wahls.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
 <20230619231611.2230-2-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619231611.2230-2-xin3.li@intel.com>
X-Proofpoint-GUID: sv3OUwB2DgkiAQGU6DCGBG-2zzGjyhJ8
X-Proofpoint-ORIG-GUID: sv3OUwB2DgkiAQGU6DCGBG-2zzGjyhJ8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Mon, Jun 19, 2023 at 04:16:09PM -0700, Xin Li wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Rename send_cleanup_vector() to vector_schedule_cleanup() for the next
> patch to replace vector cleanup IPI with a timer callback.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/include/asm/hw_irq.h       | 4 ++--
>  arch/x86/kernel/apic/vector.c       | 8 ++++----
>  arch/x86/platform/uv/uv_irq.c       | 2 +-
>  drivers/iommu/amd/iommu.c           | 2 +-
>  drivers/iommu/hyperv-iommu.c        | 4 ++--
>  drivers/iommu/intel/irq_remapping.c | 2 +-
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
> index d465ece58151..551829884734 100644
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -97,10 +97,10 @@ extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
>  extern void lock_vector_lock(void);
>  extern void unlock_vector_lock(void);
>  #ifdef CONFIG_SMP
> -extern void send_cleanup_vector(struct irq_cfg *);
> +extern void vector_schedule_cleanup(struct irq_cfg *);
>  extern void irq_complete_move(struct irq_cfg *cfg);
>  #else
> -static inline void send_cleanup_vector(struct irq_cfg *c) { }
> +static inline void vector_schedule_cleanup(struct irq_cfg *c) { }
>  static inline void irq_complete_move(struct irq_cfg *c) { }
>  #endif
>  
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index c1efebd27e6c..aa370bd0d933 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -967,7 +967,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
>  	raw_spin_unlock(&vector_lock);
>  }
>  
> -static void __send_cleanup_vector(struct apic_chip_data *apicd)
> +static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
>  {
>  	unsigned int cpu;
>  
> @@ -983,13 +983,13 @@ static void __send_cleanup_vector(struct apic_chip_data *apicd)
>  	raw_spin_unlock(&vector_lock);
>  }
>  
> -void send_cleanup_vector(struct irq_cfg *cfg)
> +void vector_schedule_cleanup(struct irq_cfg *cfg)
>  {
>  	struct apic_chip_data *apicd;
>  
>  	apicd = container_of(cfg, struct apic_chip_data, hw_irq_cfg);
>  	if (apicd->move_in_progress)
> -		__send_cleanup_vector(apicd);
> +		__vector_schedule_cleanup(apicd);
>  }
>  
>  void irq_complete_move(struct irq_cfg *cfg)
> @@ -1007,7 +1007,7 @@ void irq_complete_move(struct irq_cfg *cfg)
>  	 * on the same CPU.
>  	 */
>  	if (apicd->cpu == smp_processor_id())
> -		__send_cleanup_vector(apicd);
> +		__vector_schedule_cleanup(apicd);
>  }
>  
>  /*
> diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
> index ee21d6a36a80..4221259a5870 100644
> --- a/arch/x86/platform/uv/uv_irq.c
> +++ b/arch/x86/platform/uv/uv_irq.c
> @@ -58,7 +58,7 @@ uv_set_irq_affinity(struct irq_data *data, const struct cpumask *mask,
>  	ret = parent->chip->irq_set_affinity(parent, mask, force);
>  	if (ret >= 0) {
>  		uv_program_mmr(cfg, data->chip_data);
> -		send_cleanup_vector(cfg);
> +		vector_schedule_cleanup(cfg);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..b5900e70de60 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3658,7 +3658,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
>  	 * at the new destination. So, time to cleanup the previous
>  	 * vector allocation.
>  	 */
> -	send_cleanup_vector(cfg);
> +	vector_schedule_cleanup(cfg);
>  
>  	return IRQ_SET_MASK_OK_DONE;
>  }
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 8302db7f783e..8a5c17b97310 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -51,7 +51,7 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
>  	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
>  		return ret;
>  
> -	send_cleanup_vector(cfg);
> +	vector_schedule_cleanup(cfg);
>  
>  	return 0;
>  }
> @@ -257,7 +257,7 @@ static int hyperv_root_ir_set_affinity(struct irq_data *data,
>  	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
>  		return ret;
>  
> -	send_cleanup_vector(cfg);
> +	vector_schedule_cleanup(cfg);
>  
>  	return 0;
>  }
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index a1b987335b31..55d899f5a14b 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1180,7 +1180,7 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	 * at the new destination. So, time to cleanup the previous
>  	 * vector allocation.
>  	 */
> -	send_cleanup_vector(cfg);
> +	vector_schedule_cleanup(cfg);
>  
>  	return IRQ_SET_MASK_OK_DONE;
>  }
> -- 
> 2.34.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
