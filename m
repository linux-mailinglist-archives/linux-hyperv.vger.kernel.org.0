Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA862661C
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiKLA6j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 19:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKLA6i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 19:58:38 -0500
Received: from DM6PR05CU003-vft-obe.outbound.protection.outlook.com (mail-centralusazon11023023.outbound.protection.outlook.com [52.101.64.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE6BE20;
        Fri, 11 Nov 2022 16:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMC7dVxXJ6bqDKkWQQPp0Xbs7roHi4GnAqFlb9Xp7LPcrrmxHUuBNlJyBgAYUpepyBgGPR74UwZJj2uHqUheOTG5tuWZI0Gob2eRivAOJurpuDe11HMij60AifREv9EJfrtP9/FA5jSD4lc2/IWafMgqkbDyRiNC3ZDXdUmCs1VL7aT72ScPLnPBcc05Av4ZgCkTODbYFe+6fyuYES7KmuVHIc+UbqqIDbsmOLBMIwQWs3UffrXQqCh/m+MoN9A+3oIC6F+XofgEMfoPlh4ObsNJTOGzv0mMM3uANBwDcA64OhrUlMWSzE9XAVdZB2y5VAfpbFWIMxdfdcOej4LXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2RgyTvonTVfZ9999jljbecfBz2kK2CMF1lhk7wxvAI=;
 b=P+jmVvkU5bvNEjI2TCiPXTg5ramAeEHj5RY0li9epB7MPprLf2iyTLTi+b56iOE5G1wgeZ0geaSae7Y2CGq9Eb4kRFkimLuKFW+aT8tAewAWJsTvNHMZW0B0/28+1NL1Fja5WxTwIckXwoHgrpgRo95ZcwPK3bx9edzGLD+ZslimNyTY+cyNS6gyKbzXsATn0t+CyT8GkUhB/w40F9y1l/N8gGYznoIHEhV37YEPbTtwb4ix5smj8ha62Lrcd42g2V+KmP+9rVNPOIjenrcVkGz3Ulx3hTMOJos2m6O59bP4FvSjZMjg15YkIiieCkzsrR4c9G3Zd+kdFMYTGwYcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2RgyTvonTVfZ9999jljbecfBz2kK2CMF1lhk7wxvAI=;
 b=BiADe/4ncJpj+EUxED2X2e1Od5YIap0uEneEmG2+L2Xz7aQJzgLlGJrVwbYOciGqYypQDLbLLjq6+MNHrpsyvs6NvMdACRHsB3FdRVOTOJeX3fq15vSEJAVow0FGv0LuJ+8d7xHysOnwiPXpWsTCAwpn0v2wVdSBPt9collFzqU=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3424.namprd21.prod.outlook.com (2603:10b6:208:3e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Sat, 12 Nov
 2022 00:58:33 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5834.002; Sat, 12 Nov 2022
 00:58:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHY9bPelQKzFek9kkuOCBwYhpuQEq46Xy5g
Date:   Sat, 12 Nov 2022 00:58:33 +0000
Message-ID: <SA1PR21MB133572B296D53A64A1A6792FBF039@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221104222953.11356-1-decui@microsoft.com>
 <Y24cTE9+bqXtHics@lpieralisi>
In-Reply-To: <Y24cTE9+bqXtHics@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50364555-a158-41e5-96bf-008e7e6b76bc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-11T23:28:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3424:EE_
x-ms-office365-filtering-correlation-id: 1520f777-5e55-4cff-f0ee-08dac44905ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Z1EuU8IdEk/LZFkFhYSPd6qt6DXmQOnz024wv7eN9B5GkwS+wJ/tIuhRaIepcWnSrHbIZzjWi8hJ7by3Ce56iBcB7shEdrjHwB0s/b7BsCljrbL4Yol4Ey+DJKoWy5/6wx0phQ5VbaIWxRl8KgpV0z6WGtmpf0f35p8RLPzNYO7Mac7/hoYSxRcLEMSHVZeOorDmk+klxTvoVUVBXUAw0oe1Yd+CFNFnJkSf1ZUCP6YxMcqyG9m0FbEc2UUyTTTT2IAM+/kIg9Bo4H2JS2ORK3wHxEpuQy8uB4hESmLzN4XNrkZJ7gdC8QIYkXpsnVYDFPR3KWnVFvvpzmjs6PcikPabmW36aD7tAi1qZQaiNmWJd5/sh54Sz6nxhzULLI0v/wn1ur973DfdzfnToJPASjmseLR6CiYBmUVJiL7riFn+HecaztrrMhJ5WA8QVKLBcVcOqIAz28vtDoIRf6+htD1q3t3y0p4SJ55DfR5c3cdSbs0r36rTHKOQuE/EDLntnuJrfmzqIAzpGviv6iU4/F1waJHSJ5TTyT9BhXe+ST4laxKBK1YMeOzHgE+VViLBj9NmdbPwtHHfzvhUNrYDfY4CK54SZIiK7dP4DqQCUHbUzNm9L28xzB9m23tdw37rW+u+ugN81uTTcQ6c/rklqTN5EjxlRc74L64jRH0BRlnTkmJjZwahuz10euzWOQvu9CFD5/dHBLSd/d2eZ38S2dk/Jj7hKzH/H1+IMYm9s8QGhRxqz0sjEVRvRE6HPz5qLO4yoajG0ieSofRT51z16zgOEwZltX9jM+dT0do4jzUtSwzBKA+KCy1iK7xQtlw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(478600001)(5660300002)(2906002)(7416002)(8990500004)(38070700005)(107886003)(52536014)(54906003)(76116006)(41300700001)(83380400001)(71200400001)(8936002)(82960400001)(316002)(66946007)(8676002)(66446008)(4326008)(33656002)(55016003)(64756008)(66556008)(66476007)(186003)(86362001)(38100700002)(122000001)(110136005)(7696005)(6506007)(26005)(10290500003)(9686003)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/dq7fEd52a+BkWKPQLza+G1Ph20+dXnBKsdE6itrdn3kHE8Di1pUQM9CO6mk?=
 =?us-ascii?Q?UXuctUty4ZJSt5nfxVMIrvljajTEG6kZfgSgV2seAXtDvXJ/X0M/yF/WmDt9?=
 =?us-ascii?Q?u3yUiuuzI5woNbgan05YBFXlSlYBFPpnZ8nVBq/p8whJaFjmmKSnR0yruy1V?=
 =?us-ascii?Q?SPjEYhK4keHLnLDEHAmFsZXN11n6dsuR0lD9Q/iJG5GJlbPIngguo5L1XLX3?=
 =?us-ascii?Q?OJvRRGMV/XhIhp8fTt+OQxNpyPQgXOhh8tQG/WnpYEhXtBn9We+oEz/qU6Qb?=
 =?us-ascii?Q?lPn0H2Z5e+PaoU4y3CekHDQJRDQmgHqCQ5JbD4X6yNA6mfa1CyjpRtGjfvLG?=
 =?us-ascii?Q?28FuLgzjg6s4A3RmbkiN9JLlAGddJbgo7WH0q3obqTk+tiLMaUOfIWnd57XM?=
 =?us-ascii?Q?5OLTpHEYUkwssEjIXfil710mWCCY/+LHY3znhE5ez3apDcnVoowdhpa7m5xu?=
 =?us-ascii?Q?iR/qCQepSqzkVnWNgbN/eGw3H+80c+ETRHaFvdAo/DCtwMouJ9eGCjxx8H+R?=
 =?us-ascii?Q?Lo65lAG62WCUkiIW4GHAkznDej5zDE6753djsyLn3cpCHyt8/fSRT7an4X6K?=
 =?us-ascii?Q?pnShqNhRoAc5YWGX6VS+rQWttHHYwQ73m6VtTLolmbbIOzD0weRAG/1CS4en?=
 =?us-ascii?Q?JHNnRJWWBUka7xqpsubDArMLu+AUpNBQHdSDE0izqWAAKF45cmtEF8xJ8y41?=
 =?us-ascii?Q?RUBBnOlkUSqMAjSwcwMy6kTokUYpiTnKqHpnuL20IIGp8ZmpWkJYdY+1zxc7?=
 =?us-ascii?Q?IJo1p9qXU8oMu6KBotN0W/uD6dpY6BQ6djmzceZSzNA94KfINa5NeBhHCfBJ?=
 =?us-ascii?Q?guPbpN6ARzdxF+ZFEgOP3/lmtHxcAh5mMHlCjf8EM6eH7jC26/U6HWMFh/HZ?=
 =?us-ascii?Q?gdJ5FFnlA/OWEMiBVSIjoNcrHDDA9ev7GnnI2Kc2VBkjQ81ESjeC6d1DN++y?=
 =?us-ascii?Q?NODY3aHlSH7fGZUvTa2fooUIVFEx2tlojF6h+1mVBz2Umg/rlE7kY6TuLeoj?=
 =?us-ascii?Q?MqzMq+mtPDFJNeOf9beNetmeypIK6TNLbypYQ/cQhNY8XNVMavi2hGSSXjhU?=
 =?us-ascii?Q?CqL7lK/dk5QndvJVSgOXvohb9TXm+WvEZ98p01IWgeuwADKF5ayvQdZFhYkk?=
 =?us-ascii?Q?78OBxJ/0keQw/OAA/z/a8mCs++VnJMZ27C7owUipxLbZni1mTdAwHt0eEsVh?=
 =?us-ascii?Q?iLacLKaRtmXlLaMQ/aUaeg6L5LLgefNsfYM7tDSy3ONP+tMYdxMHxjVp8vqB?=
 =?us-ascii?Q?iUzZ0bmebPDabcqa0h7VEPWxfeXvSS+CbtYITB6fwZEXRiBK/DaLvjK7ZyPX?=
 =?us-ascii?Q?fV1ps0R5+20VuzO+rBmrdY857qcGtbFxJmbc7yUM60GGMtsXsL87RODKmDse?=
 =?us-ascii?Q?sdXZhUt8YL2vZH+yjL0r222N9KWyE534pTe+TfkayERSwutHKDpq2DPEqjdC?=
 =?us-ascii?Q?cQ259TQBzZDUYftckXK1hIkkp9Lz3d+bN8jczC1+QY1RtFFvEuSPJlOiCCy8?=
 =?us-ascii?Q?yZCLELnD7N+yrZioPN45kL2/zfJoCjmVCsZQxgZMGE636ioSLfTtoiLX6Tbi?=
 =?us-ascii?Q?wmck4gmXzgYDggm+CzVNkFUiidJOJ73vp51IpppJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520f777-5e55-4cff-f0ee-08dac44905ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 00:58:33.6990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8j3A9SL/qmeQ/5nhYnPtFPj2b1GYv6g1TBgmBoHKzZrLnidC29BrCGegGqnm0scS9m4K8Ie6o53I4K1gR33rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Sent: Friday, November 11, 2022 1:56 AM
> > ...
> > + * For the single-MSI and MSI-X cases, it's OK for
> > hv_compose_msi_req_get_cpu()
> > + * to always return the same dummy vCPU, because a second call to
> > + * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to
> > choose a
> > + * new pCPU for the interrupt. But for the multi-MSI case, the second =
call to
> > + * hv_compose_msi_msg() exits without sending a message to the vPCI VS=
P,
> > so the
>=20
> Why ? Can't you fix _that_ ? Why can't the initial call to
> hv_compose_msi_msg() determine the _real_ target vCPU ?

Unluckily I can't fix this because of the way it works in x86's irq managem=
ent
code. This is out of the control of the pci-hyperv driver.

hv_compose_msi_msg() uses irq_data_get_effective_affinity_mask() to get
the "effective"mask.

On x86, when the irq is initialized, irq_data_update_effective_affinity() i=
s
called from apic_update_irq_cfg() -- please refer to the below debug code.

When the initial call to hv_compose_msi_msg() is invoked, it's from
pci_alloc_irq_vectors(), and the x86 irq code always passes CPU0 to pci-hyp=
erv.
Please see the below "cpumask_first(cpu_online_mask)" in
vector_assign_managed_shutdown().

When hv_compose_msi_msg() is invoked the second time, it's from
request_irq(), and the x86 irq code passes the real effectivey CPU to pci-h=
yperv.

I added the below debug code and pasted the trimmed output below.

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -179,6 +179,7 @@ static void vector_assign_managed_shutdown(struct irq_d=
ata *irqd)
        unsigned int cpu =3D cpumask_first(cpu_online_mask);

        apic_update_irq_cfg(irqd, MANAGED_IRQ_SHUTDOWN_VECTOR, cpu);
+       WARN(irqd->irq >=3D 24, "cdx: vector_assign_managed_shutdown: irq=
=3D%d, cpu=3D%d\n", irqd->irq, cpu);
 }

 static int reserve_managed_vector(struct irq_data *irqd)
@@ -251,6 +252,7 @@ assign_vector_locked(struct irq_data *irqd, const struc=
t cpumask *dest)
                return vector;
        apic_update_vector(irqd, vector, cpu);
        apic_update_irq_cfg(irqd, vector, cpu);
+       WARN(irqd->irq >=3D 24, "cdx: assign_vector_locked: irq=3D%d, cpu=
=3D%d\n", irqd->irq, cpu);

        return 0;
 }
@@ -328,6 +330,7 @@ assign_managed_vector(struct irq_data *irqd, const stru=
ct cpumask *dest)
                return vector;
        apic_update_vector(irqd, vector, cpu);
        apic_update_irq_cfg(irqd, vector, cpu);
+       WARN(irqd->irq >=3D 24, "cdx: assign_managed_vector: irq=3D%d, cpu=
=3D%d\n", irqd->irq, cpu);
        return 0;
 }

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1803,6 +1803,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
        u32 size;
        int ret;

+       WARN(1, "cdx: hv_compose_msi_msg: irq=3D%d\n", data->irq);
        /* Reuse the previous allocation */
        if (data->chip_data) {
                int_desc =3D data->chip_data;

  1 cdx: vector_assign_managed_shutdown: irq=3D24, cpu=3D0
  2 WARNING: CPU: 3 PID: 87 at arch/x86/kernel/apic/vector.c:182 vector_ass=
ign_managed_shutdown+0x53/0x60
  3 RIP: 0010:vector_assign_managed_shutdown+0x53/0x60
  4  reserve_irq_vector_locked+0x41/0xa0
  5  x86_vector_alloc_irqs+0x298/0x460
  6  irq_domain_alloc_irqs_hierarchy+0x1b/0x50
  7  irq_domain_alloc_irqs_parent+0x17/0x30
  8  msi_domain_alloc+0x83/0x150
  9  irq_domain_alloc_irqs_hierarchy+0x1b/0x50
 10  __irq_domain_alloc_irqs+0xdf/0x320
 11  __msi_domain_alloc_irqs+0x103/0x3e0
 12  msi_domain_alloc_irqs_descs_locked+0x3e/0x90
 13  pci_msi_setup_msi_irqs+0x2d/0x40
 14  __pci_enable_msix_range+0x2fd/0x420
 15  pci_alloc_irq_vectors_affinity+0xb0/0x110
 16  nvme_reset_work+0x1cf/0x1170
 17  process_one_work+0x21f/0x3f0
 18  worker_thread+0x4a/0x3c0
 19  kthread+0xff/0x130
 20  ret_from_fork+0x22/0x30
 21
 22 cdx: vector_assign_managed_shutdown: irq=3D24, cpu=3D0
 23 WARNING: CPU: 3 PID: 87 at arch/x86/kernel/apic/vector.c:182 vector_ass=
ign_managed_shutdown+0x53/0x60
 24 RIP: 0010:vector_assign_managed_shutdown+0x53/0x60
 25  x86_vector_activate+0x149/0x1e0
 26  __irq_domain_activate_irq+0x58/0x90
 27  __irq_domain_activate_irq+0x38/0x90
 28  irq_domain_activate_irq+0x2d/0x50
 29  __msi_domain_alloc_irqs+0x1bb/0x3e0
 30  msi_domain_alloc_irqs_descs_locked+0x3e/0x90
 31  pci_msi_setup_msi_irqs+0x2d/0x40
 32  __pci_enable_msix_range+0x2fd/0x420
 33  pci_alloc_irq_vectors_affinity+0xb0/0x110
 34  nvme_reset_work+0x1cf/0x1170
 35  process_one_work+0x21f/0x3f0
 36  worker_thread+0x4a/0x3c0
 37  kthread+0xff/0x130
 38  ret_from_fork+0x22/0x30
 39
 40
 41 cdx: hv_compose_msi_msg: irq=3D24
 42 WARNING: CPU: 3 PID: 87 at drivers/pci/controller/pci-hyperv.c:1806 hv_=
compose_msi_msg+0x3f/0x5d0 [pci_hyperv]
 43 RIP: 0010:hv_compose_msi_msg+0x3f/0x5d0 [pci_hyperv]
 44  irq_chip_compose_msi_msg+0x32/0x50
 45  msi_domain_activate+0x45/0xa0
 46  __irq_domain_activate_irq+0x58/0x90
 47  irq_domain_activate_irq+0x2d/0x50
 48  __msi_domain_alloc_irqs+0x1bb/0x3e0
 49  msi_domain_alloc_irqs_descs_locked+0x3e/0x90
 50  pci_msi_setup_msi_irqs+0x2d/0x40
 51  __pci_enable_msix_range+0x2fd/0x420
 52  pci_alloc_irq_vectors_affinity+0xb0/0x110
 53  nvme_reset_work+0x1cf/0x1170
 54  process_one_work+0x21f/0x3f0
 55  worker_thread+0x4a/0x3c0
 56  kthread+0xff/0x130
 57  ret_from_fork+0x22/0x30
 58
 59
 60
 61 cdx: assign_vector_locked: irq=3D24, cpu=3D3
 62 WARNING: CPU: 0 PID: 87 at arch/x86/kernel/apic/vector.c:255 assign_vec=
tor_locked+0x160/0x170
 63 RIP: 0010:assign_vector_locked+0x160/0x170
 64  assign_irq_vector_any_locked+0x6a/0x150
 65  x86_vector_activate+0x93/0x1e0
 66  __irq_domain_activate_irq+0x58/0x90
 67  __irq_domain_activate_irq+0x38/0x90
 68  irq_domain_activate_irq+0x2d/0x50
 69  irq_activate+0x29/0x30
 70  __setup_irq+0x2e5/0x780
 71  request_threaded_irq+0x112/0x180
 72  pci_request_irq+0xa3/0xf0
 73  queue_request_irq+0x74/0x80
 74  nvme_reset_work+0x408/0x1170
 75  process_one_work+0x21f/0x3f0
 76  worker_thread+0x4a/0x3c0
 77  kthread+0xff/0x130
 78  ret_from_fork+0x22/0x30
 79
 80 cdx: hv_compose_msi_msg: irq=3D24
 81 WARNING: CPU: 0 PID: 87 at drivers/pci/controller/pci-hyperv.c:1806 hv_=
compose_msi_msg+0x3f/0x5d0 [pci_hyperv]
 82 RIP: 0010:hv_compose_msi_msg+0x3f/0x5d0 [pci_hyperv]
 83  irq_chip_compose_msi_msg+0x32/0x50
 84  msi_domain_activate+0x45/0xa0
 85  __irq_domain_activate_irq+0x58/0x90
 86  irq_domain_activate_irq+0x2d/0x50
 87  irq_activate+0x29/0x30
 88  __setup_irq+0x2e5/0x780
 89  request_threaded_irq+0x112/0x180
 90  pci_request_irq+0xa3/0xf0
 91  queue_request_irq+0x74/0x80
 92  nvme_reset_work+0x408/0x1170
 93  process_one_work+0x21f/0x3f0
 94  worker_thread+0x4a/0x3c0
 95  kthread+0xff/0x130
 96  ret_from_fork+0x22/0x30

> > + * original dummy vCPU is used. This dummy vCPU must be round-robin'ed
> > so that
> > + * the pCPUs are spread out. All interrupts for a multi-MSI device end=
 up
> > using
> > + * the same pCPU, even though the vCPUs will be spread out by later ca=
lls
> > + * to hv_irq_unmask(), but that is the best we can do now.
> > + *
> > + * With current Hyper-V, the HVCALL_RETARGET_INTERRUPT hypercall does
> *not*
>=20
> "current" Hyper-V means nothing, remove it or provide versioning
> information. Imagine yourself reading this comment some time
> in the future.

Good point. @Wei, can you please help fix this? I think we can change
"With current Hyper-V"
To
"With Hyper-V in Nov 2022".

BTW, it's hard to provide the exact versioning info, because technically
there are many versions of Hyper-V...

> I can't claim to understand how this MSI vCPU to pCPU mapping is made to
> work in current code but I can't ack this patch sorry, if you feel like
> it is good to merge it it is your and Hyper-V maintainers call, feel
> free to go ahead - I can review PCI hyper-V changes that affect PCI
> and IRQs core APIs, I don't know Hyper-V internals.
>=20
> Lorenzo

I understand. Thanks!=20

I discussed the issue with Hyper-V team. I believe I understood it and
this patch is the right thing to have.

@Wei, Bjorn spotted two typos in the commit message, and Lorenzo
suggested a change to the above "current". Can you please help
fix these and merge the patch? Or, let me know if it'd be easier if
I should send v4.

Thanks,
Dexuan

