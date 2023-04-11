Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDDA6DE279
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Apr 2023 19:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDKR1q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Apr 2023 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDKR1p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Apr 2023 13:27:45 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150A130;
        Tue, 11 Apr 2023 10:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvN+zS4YgaHX/Ay1xntNUNNgC7idvtxvpvMJB9I+dGbnswxemHl4jCErlC3E4Z+Ot2pjKlUDVPv1nYECfKKaRro+1WrGmEkkRLSOIn8tBMLfPTpTsBtS39zXxeWwVGL1EjcrelU2ZbPBAk95+UFSMhTV9MXRexYvFAtKD/sw5BfMV+cNx6I7S51HKJJrPh8WkNiqp7rucxzTQN/CmhR90BV2X+Sasf5ELx3EhmaueU4DUEtN98JF/wo7v7omIpnuErvWHBWRe/QSkkRe/YYjL/xbUhm2VlvQDm/z2VOEcsSXHkWolbnMuGZiMdvd0Cr6NR766WUO0F5jA1jSOwrhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/i4L5pDbqinp2WtnjFeOQ4TFGMdsrcp9AU/GVNZHz8=;
 b=VqLtrCoRG/AMRfQXpTYj2jHfz+58FepRcDlCNFuZGKmu45meHbLYQE052fUN4JrgdMW/9NdFLXMbAtFSlF+WasaJYaFqaplAZp5rsiLXQAJJpjSN6xD4gMPhYvxN5z35w8FDYjpyzQnKBRbibJTMDLkqABgOS4QGUSUeQqB0uL7hEqOeveQpy56n9uTMh2hnfE7e7FYsKZggEyNt7LySngEwEvFTVOO4eTJj792iB8C8ITBvtomtxfpos6ROlh0h6EYOeqwxhmoHRbWOwvliy3EAOiEHvgEPiPlMRjaA0HwZgpduFlmrAhMtRVihcRCfz8q4nnPq7wAigfUPVuQ6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/i4L5pDbqinp2WtnjFeOQ4TFGMdsrcp9AU/GVNZHz8=;
 b=B8fFYhR9HYFGV5P1y3cPwPfNURAq1BsIfMk/I7JyMQu/58t3JlmXvlQbYP7Y2BBrThdWDzyQqY0HGa7iXoSkakZBOBhi3br6QaA15aBIhr5xKIkmeV+oLAcJzdeCZKHUxOZy0q2F1cfs1Q7Ee9TIx2rvKIqcA6F/asuYJBfEWcs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3774.namprd21.prod.outlook.com (2603:10b6:8:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 17:27:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 17:27:41 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Thread-Topic: [PATCH] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Thread-Index: AQHZal7BSHLzKGubX0KU07XgAcb7368mYESQ
Date:   Tue, 11 Apr 2023 17:27:41 +0000
Message-ID: <BYAPR21MB1688F1E184FD1A914637EFB0D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408211112.15235-1-decui@microsoft.com>
In-Reply-To: <20230408211112.15235-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c117e0dd-37cd-4017-a59c-87368fe01810;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T17:24:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3774:EE_
x-ms-office365-filtering-correlation-id: 10ee0723-70f2-4b34-72d2-08db3ab20db6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSptPpkJ/RGiNBiygfnQltr52vVjc+cen9u+5w5hkW0fOoHXNqMG9/B4MIiamUPbk1RNXuGwKN+U4DQaryePLVpBY657y9Fpl8kiMifX8ZFBJW3ei3fYOpQN091mJO5+rydxdtQf9/G+I2gj/xCsJxADORmSGxSZsK/yDFrroZ2u762yG444I8MOGRT2IMUqKy90aDr72w40c7qIhrN6JqtnGa1hCX8nglWjWX1iCexo78zmxeGxgOFatqroBncJbdbEe5BefOdA0fWDFEGdv68BgLlckOAR6iIGvjPVqRK6+onyy2yUxZmv3jTxUO4VmyRcqSPZ+nn0JPFDiDBCTYkVUJVxnKc6aS+//WaGMHEKOP0USuXazTk1F7v6fY7+CwOFXGUHCYXU4x/1kP3nTfMqrKT6QvtnJz2XrLuWMciTIJzv6BQffffGZ/x9ywAX9aerZaWI8MUcKiLbexy3qGkkoQ0QlrqterAZqfM63tRLSYZXfZFnLUD+mUsdqRpRon+ylZhc/xKBBt2H9F7hDQEtJVpTYigWR2Iu3fCzWeFfPDy7181QyMj0jGoMTrMQxsd74lcZ2UvNULnIymEBgt0R1YnoJFa85Iz84IRHCBJILmntI846m/1INkLIGhYMqllGjBBzQ8h7bq7PiLU8o8yFtTBUU2I/vQ6H9vkqzcOVbV81fLiVNH/KDJ3N4spe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(110136005)(8990500004)(478600001)(10290500003)(33656002)(82950400001)(82960400001)(38070700005)(52536014)(5660300002)(8676002)(8936002)(66446008)(64756008)(66556008)(4326008)(66476007)(66946007)(76116006)(41300700001)(316002)(786003)(921005)(122000001)(2906002)(38100700002)(55016003)(7696005)(26005)(6506007)(9686003)(83380400001)(186003)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hPsCPQUA7oluBEzY53vy6iXWvNerIizDAjrAiQvk+fs+r/FeI8ehe34Do9Kj?=
 =?us-ascii?Q?G292KlXNkN/PFioRQeTqyueJ0GkzAbAh7gmQ7epkn/Xfp0TrDuFodttgAIxn?=
 =?us-ascii?Q?qmYClqzNph6bI+tIetjdXWA/lyJa9luCSKStu7W+WhEda2E3pa6AYq0gI9C9?=
 =?us-ascii?Q?XrzrSGlFp/113xPVvI++Wnm9zJo0GRGnBZGdWb7l48S0Bj1nANf859xclLJB?=
 =?us-ascii?Q?rziu+XbeacbMpBxmlMe42zqTSKILRDvGUW5DpRSaPOFKoflocwJ0KtbiRCQP?=
 =?us-ascii?Q?+hRe0w0wznurfcc7fFwuEl30NLPm4CErDehhh1Cv28ZfVPqsfC67xIe/FMWq?=
 =?us-ascii?Q?hJIJf7q3IvhxJsodZgVzVKyWcLoYHpgID77HDt/SZV/dFKRYzVs4MphpRjv0?=
 =?us-ascii?Q?yrTo5P/1XlYYFGw0BotsE6IQyH61Ss4qkLQ54cjqUpZiGqorwsQzuhkwK3Zb?=
 =?us-ascii?Q?nUqtowngkccbv5tlcZRdQyRhR4bQkAYK6iKQVoY0z5zh5hmG/HBTh2dIPVHg?=
 =?us-ascii?Q?TWLodTZ5GpNq5/E5jgd4gtxepzRQ9sxrTwepsF+6Dh+e+NgY1crfQqIWQeL0?=
 =?us-ascii?Q?mBU82IY6//3KKOULNnEBm/7iFhf05d0pRR1HlHgiuGrUr1UPrIFvv2ETPyT6?=
 =?us-ascii?Q?539hvpWKYEvDSKQUY+ImlFxc4ocMfiXpV7xETrlJ4t+j0+mnNYmJgyMJjukZ?=
 =?us-ascii?Q?8USD+pHVWVpwO+oaHSvRCT/7zpasOgyLF5bk5GIlWMvMNim3m+v30vN3Cjrh?=
 =?us-ascii?Q?1LUHyKTeZqlqt1xAvF46u9q1ZsoGaq6E0yJw1uSvA0udCdPjHe4RLCX7+eJ0?=
 =?us-ascii?Q?in38LMo/8EuJ0DtOEBsSNwzTMaqX9btAfCdaBM63Jv/fJyGJzfGMGW4JyIh3?=
 =?us-ascii?Q?Qfv+BOFPhZiQ2VbHGN83mTKOYU+e518nqM6zR7JLNnuLJTw58Kp2AAL875sB?=
 =?us-ascii?Q?iooZXUVTF7y/M0wlllJyVUIfYrU20aI+Z92ODY016oN061VBCUO2Y2TH++D0?=
 =?us-ascii?Q?EuAjsjtTAIQSHTOPauOSLheN4lae8BkJvqS+ZiS88q1nv43vk0Yvc9MkMbKj?=
 =?us-ascii?Q?GRKgJkUunYr3yqRIEPxbBPYxxEMedDr8jqNeEn0y//nyqeGoMwi0IxczX1cT?=
 =?us-ascii?Q?kkV64WIDEqdXo6HSjOjpFvuaz10f+OK1roi6Hzo0hwWl0gqllz6lbLdBUrId?=
 =?us-ascii?Q?Q962zkm1zXyk5bDQOeHfKYmijnoUnUZiFTvgLg05X63DvMUCCelb7xLMd2Po?=
 =?us-ascii?Q?QKCAXZqMuMHdZ9iD/FY8MXuseQnhcym0A1mrcn9qN8HnrBkWCO/U5ACNYaNC?=
 =?us-ascii?Q?f6toVMtS7eP8JDW6W4+8I4pEnMNB4JQtBk0jeIO9dAjbckeeiqF1SGhowIqE?=
 =?us-ascii?Q?R3Kcpcz/0zSFY0r7G+FvJHnWKtkkQ+owHqYVPZp4kI4LqaHV9klmvgOiwlag?=
 =?us-ascii?Q?4gd6MBuJf+YIZ8gbWl6ohGHwwKzIH2CO0xiEJtV380u9Jbyaj6+/165YudyE?=
 =?us-ascii?Q?Uck8ttu77/hRrRpogOIBxu0H4n2t9Ytl/9XoQa1cVts+6du1UNcEmaHG47cN?=
 =?us-ascii?Q?hWPecTQfDD7VCWuJuBxiZL4YmhJ6Qtrds83LWGuGRuV5B6aSYVIBGA/x+ONo?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ee0723-70f2-4b34-72d2-08db3ab20db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 17:27:41.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHiBYWOdAL4DakKWuaP0z6hBKU3Z+xWryb5XsjkMSAHYpLlaee1QcavNEHNeVCIAJcD0T8v3mG9fZaj11FfIncsloU0KQOycpiKLtACnJnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3774
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 2:11 P=
M
>=20
> 4 commits are involved here:
> A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous h=
ypercall
> params buffer")
> B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus str=
ucture")
> C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive =
caused by
> the hbus buffer")
> D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
>=20
> Patch D introduced the per-CPU hypercall input page "hyperv_pcpu_input_ar=
g"
> in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercal=
l
> input page "hbus->retarget_msi_interrupt_params" that was added in patch =
A,
> and the issue addressed by patch B is no longer an issue, and we can also
> get rid of patch C.
>=20
> The change here is required for PCI device assignment to work for
> Confidential VMs (CVMs), because otherwise we would have to call
> set_memory_decrypted() for "hbus->retarget_msi_interrupt_params" before
> calling the hypercall HVCALL_RETARGET_INTERRUPT.

Well, not all CVMs.  It's not required for SEV-SNP vTOM VMs on Hyper-V beca=
use
of the paravisor.  Is it more accurate to say "for Confidential VMs (CVMs) =
running
without a paravisor"?

Otherwise,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 48 +++++------------------------
>  1 file changed, 7 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 337f3b4a04fc0..bc32662c6bb7f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -508,20 +508,11 @@ struct hv_pcibus_device {
>  	struct msi_domain_info msi_info;
>  	struct irq_domain *irq_domain;
>=20
> -	spinlock_t retarget_msi_interrupt_lock;
> -
>  	struct workqueue_struct *wq;
>=20
>  	/* Highest slot of child device with resources allocated */
>  	int wslot_res_allocated;
>  	bool use_calls; /* Use hypercalls to access mmio cfg space */
> -
> -	/* hypercall arg, must not cross page boundary */
> -	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
> -
> -	/*
> -	 * Don't put anything here: retarget_msi_interrupt_params must be last
> -	 */
>  };
>=20
>  /*
> @@ -645,9 +636,9 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
>  	int_desc =3D data->chip_data;
>=20
> -	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> +	local_irq_save(flags);
>=20
> -	params =3D &hbus->retarget_msi_interrupt_params;
> +	params =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id =3D HV_PARTITION_ID_SELF;
>  	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
> @@ -680,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>=20
>  		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
>  			res =3D 1;
> -			goto exit_unlock;
> +			goto out;
>  		}
>=20
>  		cpumask_and(tmp, dest, cpu_online_mask);
> @@ -689,7 +680,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>=20
>  		if (nr_bank <=3D 0) {
>  			res =3D 1;
> -			goto exit_unlock;
> +			goto out;
>  		}
>=20
>  		/*
> @@ -708,8 +699,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	res =3D hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
>  			      params, NULL);
>=20
> -exit_unlock:
> -	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
> +out:
> +	local_irq_restore(flags);
>=20
>  	/*
>  	 * During hibernation, when a CPU is offlined, the kernel tries
> @@ -3598,35 +3589,11 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	bool enter_d0_retry =3D true;
>  	int ret;
>=20
> -	/*
> -	 * hv_pcibus_device contains the hypercall arguments for retargeting in
> -	 * hv_irq_unmask(). Those must not cross a page boundary.
> -	 */
> -	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
> -
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
>  	if (!bridge)
>  		return -ENOMEM;
>=20
> -	/*
> -	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
> -	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
> -	 * a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
> -	 * alignment of hbus is important because hbus's field
> -	 * retarget_msi_interrupt_params must not cross a 4KB page boundary.
> -	 *
> -	 * Here we prefer kzalloc to get_zeroed_page(), because a buffer
> -	 * allocated by the latter is not tracked and scanned by kmemleak, and
> -	 * hence kmemleak reports the pointer contained in the hbus buffer
> -	 * (i.e. the hpdev struct, which is created in new_pcichild_device() an=
d
> -	 * is tracked by hbus->children) as memory leak (false positive).
> -	 *
> -	 * If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
> -	 * used to allocate the hbus buffer and we can avoid the kmemleak false
> -	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
> -	 * kmemleak to track and scan the hbus buffer.
> -	 */
> -	hbus =3D kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	hbus =3D kzalloc(sizeof(*hbus), GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
>=20
> @@ -3683,7 +3650,6 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	INIT_LIST_HEAD(&hbus->dr_list);
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
> -	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
>  					   hbus->bridge->domain_nr);
>  	if (!hbus->wq) {
> --
> 2.25.1

