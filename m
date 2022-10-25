Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFE60D374
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Oct 2022 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiJYSSc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Oct 2022 14:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJYSSb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Oct 2022 14:18:31 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023022.outbound.protection.outlook.com [52.101.64.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE82397D58;
        Tue, 25 Oct 2022 11:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4WY3Hehm/ohWmuDg6itc2iEauRo/lpNNWasFizajJwE5vsOw9SZxZFpU5vq2exJYVGElX+T/MlIQOLioXYS8AXw9PvGl1pKdFh8GxuvOHoSZH6x6XIMRTvyZ00PmKFwnDQAT7UeXSNaoTCNoQozqnI5E/s3fYa8WVODPjrnHrORAhVDXVJY66SAmvKsqamBg5asjgrC8GSSS1IVgfTc1ejx+yajmhHtVufJG5JwUf3Wsdko6Ayyiq/QWD2jDBbfDeBU90kF7g6+bVl9BlBM+cnerITx1RtC16L7mtyya1h+vIlqhjzpsd6pWZiZ5Cqs0MD1qV3XB3+Tbs2y3Aff2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgO0osG/cxQ1JtwjiilxM4mwYiTuxKqMNDUoiPZo3hI=;
 b=imdKGznfXu3BjLcwzL2WkWoIIiAmIZ/7lUvy4iJah/PTtoCXYr9ClXz3Akr+j0AvqVP9eSGG+RrdZHC9cGPTzkcjSjxTsJttHw0y86zz5gTbK7a7i3QdxDAo8EBTtBmWCSdYWBkNKTjUSkJmA09MSncDRH4ehkO72PqBm57V4rO9qBpdcn/IKUta/9+ZIHtSa+ZML+2z1uQWJu6dmzowUzLBaumd550QjaAnHjwvSb/nH41Kkk++4qcwWAipZLR0m3jAOTdsrtlzvAhWo7ymxQB1jgtj8p5n/LYIQ2QpJSfpo2Z62YiwoMw1/IJ8e8lBHi2iJ+/j7+b89gzcmRybfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgO0osG/cxQ1JtwjiilxM4mwYiTuxKqMNDUoiPZo3hI=;
 b=bWJGWnbCmuEJNVsakWAQ8tBLwY9Rn6JboFauTSd6fcaL/OUa6WL/b9MBL0sdYxFwt+imYnPPUdr3I8m8A5NM/8+fIYh0gnItszOfi9f8KGONPvY6iuPdWQ2q2AkvlJaCigb5GBCUfXMWpxt7xhYwX5tc1hQ1bWuSAAImU8ELUhg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3439.namprd21.prod.outlook.com (2603:10b6:208:3d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.8; Tue, 25 Oct
 2022 18:18:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5791.008; Tue, 25 Oct 2022
 18:18:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH v2] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH v2] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHY6AEkY2TDPPxGMUaLzNKIsTJo9a4faSzA
Date:   Tue, 25 Oct 2022 18:18:23 +0000
Message-ID: <BYAPR21MB16883E16789C7F8DBC965CCDD7319@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221024233342.22758-1-decui@microsoft.com>
In-Reply-To: <20221024233342.22758-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d66bf82-f0a4-4933-b4a0-1e42373af77b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-25T18:07:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3439:EE_
x-ms-office365-filtering-correlation-id: 1ece1bde-f21f-492d-e47a-08dab6b54d8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3Nu5f2MYkJjgMGU407WBd6mvGqrOJu+I/6Opucof+wObc2ULo4wUBh5Gu7uSM5PnM+2xelXnOJ+1LMo+PNysqegqsXwFvpKsZ1nFQ+2K3QeQ1ylod1sko+xBWC/YnBCl2bWya5vmA8P7QuLpRbWH0K/+79Rjr1mw3Iw4CJwpGgAKRykjm4028rDLZyXdTNOo9jeHxS2GQOS4NYWjO2WqxtmXJ1eapvnbbkmJjcppUMzAxNKraarTqgtiO/bz6QQlgKXZ8p9DXEtexvU01ZqGEMnwDJpmEi56JZZppGnM2cQp+2PDSasN7qDKjabEpIl8kk2dcBAM7vIDf/UuZf71ciJpOL61eq7/7MYACJOA6ZCOLxjaWTlQGhjlK2QPkkyuR5AyBvU3D7//x2h/GwPqCraMMLMWf4aUjwIsDtwrtCawIcZydUMCM4j4NrzVgePLZafzyhbOWFTSMxXO0uXXMPxF6wVhagZ1/Y983XxEm5k2bv49qJQSweSMS7tQiPWl/xG4imwKys7MTIQTT85srPdrppMB6JHi7OEiHgL1Ym4+pPflNTHBLdrw+ZnK2lK6TZa1y16fVilsArGZuWBLRm5tBMuWBL4858SokVjrfSY83uBKwQ8MHT3nBd3mq+DtvMTaWYarlxRnC5SSz1DkytIv33EBpci1ydb+Sy3Q+IGFhsZH+2kvVSp1BMDyUQs48zLQGWtG7xVNzmyjS5+BgMUTJ6tlNYEj/4kMqa45g/Vd06jQi4YGIciNYJcNqDhLZ7Yy1LUArTgq5UjbywuBLf1wDgPxlpkVxwy9aHXmlMu+LfpNig0HjNtTu9NHDXJabEnhNzmELcMBg1p9EGYMwEQJ8Lrbu2bN2sSR8BU1bE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(2906002)(8990500004)(186003)(26005)(9686003)(55016003)(478600001)(966005)(83380400001)(71200400001)(82950400001)(82960400001)(7696005)(6506007)(41300700001)(38070700005)(921005)(86362001)(10290500003)(33656002)(8936002)(316002)(110136005)(52536014)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(8676002)(122000001)(6636002)(38100700002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYn6Umef3b98lcab5FTazZ2hBprzVL9ykbXwv2ZuM56ni1hY/OII1Iet4Ck0?=
 =?us-ascii?Q?0r0aq4oTV/q51Allj5T1k7BKghv0x7kQQvHGfeqgKlulA0y15IBLHT5SEHJE?=
 =?us-ascii?Q?t9h1dT7THyxTaQJfRc7SNRZzCAH1K+fvxizNuyguZIuX31QmvG1X/tdlOoSv?=
 =?us-ascii?Q?ytyL5v2tIx5ReOdeKGVVApyR3blc9KRjByrnWddG+vT/uWWAupF1poK2LwEZ?=
 =?us-ascii?Q?StADTej/XtG1LhdjY+YlCX/NUR5HnxbFFai6ShoJKGUwV8PnUc1vJEeUyeT5?=
 =?us-ascii?Q?mVZb15T3b0bMYD8Svw7fipug1r7DWiB37Wvb0wEoPuXDgZFiciqh7r5A9MAN?=
 =?us-ascii?Q?V1I6XSpBe4d8e+5q8wW9CL01tEKORqz0dhO1R+yY973VSUPA/2M0VNDktcIu?=
 =?us-ascii?Q?ye9LRN16+HsomC6OQ7arRLOcZP/XIDaq4hRvWsgpgFSLukoAjRO0tgXqPaPp?=
 =?us-ascii?Q?NSphEPgvcU9iqdODkeuB9BOm6CCgIe2bGL/qIcPEGtHhTRVneoEQNeafg00G?=
 =?us-ascii?Q?z9kdEcfzLLrIq3iZ0tLv/ElT3iUFBo6JoksW1+EyeblO43oQZ8mg7DrBFNeq?=
 =?us-ascii?Q?yEzHi/xoS5JEDwXHgsU4fasn2owNi6VRHVFtWh1og0p6atX0SuDFcWNIoyyi?=
 =?us-ascii?Q?/y7O3L3P2+LIkgFHD0nOlJ+oA0l2LH0m+Ph9cAngVjX3SwFviGuBgoe4fX8Z?=
 =?us-ascii?Q?2bZ1vKsU6H45COndKbemycL9e6MHVpFtH82+anb80VKfT+5e2WCIWjocRs2e?=
 =?us-ascii?Q?RvuNBl3wp3Tvd7TxkDg0ibDf7635IPBgkfePfHRZfx9MKH6oPTpWgH4PEwp0?=
 =?us-ascii?Q?v7tkm/LHJIJGN4Id4oiBPIgCq08uSokwIj7NyqGoyKJvnDNZDsfA4r2Zqapg?=
 =?us-ascii?Q?wXQpwOgngY8WM89a2Kg23RUn7AmbBcjV7vuHqjsCugyZIsiN44K7VcJ6pbbn?=
 =?us-ascii?Q?YubMyBGYg31FGn32aSwkL5uGt7vfz1Mywlk0Qx1LwW6aEzg93ukI2H0FDuk9?=
 =?us-ascii?Q?PDZExRUvToluAIPc8LmqPNDaMDrpl0Z2tgLDBcXURKflpOivqjvAg61jnvxk?=
 =?us-ascii?Q?e2w96rmy83iaL/4Ih2PsEKnxmrrLRKmJmJVPZr+Z3eD/AkjNgksulsbNY53x?=
 =?us-ascii?Q?DMptCOi96rxCAYffFzis/dpJzu33tUjXLZ62+hiw3l3v3b0XV8Bkplc7YAxR?=
 =?us-ascii?Q?GV5bGkMpYIQ+9nQA3I1Rx+PLJOAeutm0kEmLfABN4U6CyVxeh3tgTB+nh17c?=
 =?us-ascii?Q?irIh0WWFNhCewgvuf2jTtMyVXwnitaWAceGPF1ixdLIBOktp1NRzjOzFfg56?=
 =?us-ascii?Q?KWLMmt0BZdzZpnJK3Mp0CpCNLZm5JKdokUudCW/j1LyMncY7pjsFd33u1F7l?=
 =?us-ascii?Q?/l8H5cTEyVaPBetxMrMRf7Far/isG7eVR1ObtJdT2iEapeH8ULoVKwxOGqRq?=
 =?us-ascii?Q?WyWFFGFkbaPo1URczNtZn7Ii++f48lAcgNr4DJzcyXnR4l9QfWsGvBHKlRR5?=
 =?us-ascii?Q?6ASb0FPVPhzKYBVs/cPZw3VxU+KRG+2p7b9+MV0e0tBN4K/0nlL7n/hJQqBH?=
 =?us-ascii?Q?kwXmeVVS4bksZkf3+J7ZsKunSc5iP0EvMji7X9OqF9Ww32pFHke5bm4eB3v+?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ece1bde-f21f-492d-e47a-08dab6b54d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 18:18:23.2736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5Kj4aZEy2AQ00G+Idr0ZZOpUzgIUHyKmCnJrK1Yr1UWrxpQYhFbA7oBki7y6ik7A+n6Lt6lBKjki/GMp1QB/A9hYKKXWaqT8m0gx0viBJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3439
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, October 24, 2022 4:34 =
PM
>=20
> Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches=
:
> 08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
> 455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
> b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg=
()")
> a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
>=20
> It turns out that the third patch (b4b77778ecc5) causes a performance
> regression because all the interrupts now happen on 1 physical CPU (or tw=
o
> pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PC=
I
> devices, it may suffer from soft lockups if the workload is heavy, e.g.,
> see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsof=
t.com/
>=20
> Commit b4b77778ecc5 itself is good. The real issue is that the hypercall =
in
> hv_irq_unmask() -> hv_arch_irq_unmask() ->
> hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
> virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
> determined only once in hv_compose_msi_msg() where only vCPU0 is specifie=
d;
> consequently the hypervisor only uses 1 target pCPU for all the interrupt=
s.
>=20
> Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCP=
U
> is determinted the second time, the vCPU in the effective affinity mask i=
s
> used (i.e., it isn't always vCPU0), so the hypervisor chooses a different
> pCPU for each interrupt.
>=20
> The hypercall will be fixed in future to update the pCPU as well, but
> that will take quite a while, so let's restore the old behavior in
> hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
> manner for each PCI device, so the interrupts of different devices can
> happen on different pCPUs, though the interrupts of each device happen on
> some single pCPU.
>=20
> The hypercall fix may not be backported to all old versions of Hyper-V, s=
o
> we want to have this guest side change for ever (or at least till we're s=
ure
> the old affected versions of Hyper-V are no longer supported).
>=20
> Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_=
msi_msg()")
> Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
> v1 is here:
>=20
> https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.co=
m/
>=20
> Changes in v2:
>   round-robin the vCPU for multi-MSI.
>   The commit message is re-worked.
>   Added Jeff and Carl's Co-developed-by and Signed-off-by.
>=20
>=20
>  drivers/pci/controller/pci-hyperv.c | 61 ++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e7c6f6629e7c..7ac080f95259 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, str=
uct
> pci_response *resp,
>  }
>=20
>  static u32 hv_compose_msi_req_v1(
> -	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
> +	struct pci_create_interrupt *int_pkt,
>  	u32 slot, u8 vector, u8 vector_count)
>  {
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE;
> @@ -1640,18 +1640,39 @@ static int hv_compose_msi_req_get_cpu(const struc=
t cpumask *affinity)
>  	return cpumask_first_and(affinity, cpu_online_mask);
>  }
>=20
> -static u32 hv_compose_msi_req_v2(
> -	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
> -	u32 slot, u8 vector, u8 vector_count)
> +/*
> + * Make sure the dummy vCPU values for multi-MSI don't all point to vCPU=
0.
> + */
> +static int hv_compose_multi_msi_req_get_cpu(void)
>  {
> +	static DEFINE_SPINLOCK(multi_msi_cpu_lock);
> +
> +	/* -1 means starting with CPU 0 */
> +	static int cpu_next =3D -1;
> +
> +	unsigned long flags;
>  	int cpu;
>=20
> +	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
> +
> +	cpu_next =3D cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
> +				     false);

I have a modest concern about using cpu_online_mask.  The CPUs in this mask
can change if a CPU is taken online or offline in Linux.   I don't think th=
ere's
a requirement to pick on an online CPU, especially since if we pick a CPU t=
hat's
online now, it might not be online later.  Using cpu_present_mask would be
more correct.  That's the CPUs that are present in the VM, which won't chan=
ge
over time since Hyper-V doesn't hot-add or hot-remove CPUs in a VM.

A similar concern applies to hv_compose_msi_req_get_cpu().

Michael

> +	cpu =3D cpu_next;
> +
> +	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
> +
> +	return cpu;
> +}
> +
> +static u32 hv_compose_msi_req_v2(
> +	struct pci_create_interrupt2 *int_pkt, int cpu,
> +	u32 slot, u8 vector, u8 vector_count)
> +{
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE2;
>  	int_pkt->wslot.slot =3D slot;
>  	int_pkt->int_desc.vector =3D vector;
>  	int_pkt->int_desc.vector_count =3D vector_count;
>  	int_pkt->int_desc.delivery_mode =3D DELIVERY_MODE;
> -	cpu =3D hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =3D
>  		hv_cpu_number_to_vp_number(cpu);
>  	int_pkt->int_desc.processor_count =3D 1;
> @@ -1660,18 +1681,15 @@ static u32 hv_compose_msi_req_v2(
>  }
>=20
>  static u32 hv_compose_msi_req_v3(
> -	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
> +	struct pci_create_interrupt3 *int_pkt, int cpu,
>  	u32 slot, u32 vector, u8 vector_count)
>  {
> -	int cpu;
> -
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE3;
>  	int_pkt->wslot.slot =3D slot;
>  	int_pkt->int_desc.vector =3D vector;
>  	int_pkt->int_desc.reserved =3D 0;
>  	int_pkt->int_desc.vector_count =3D vector_count;
>  	int_pkt->int_desc.delivery_mode =3D DELIVERY_MODE;
> -	cpu =3D hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =3D
>  		hv_cpu_number_to_vp_number(cpu);
>  	int_pkt->int_desc.processor_count =3D 1;
> @@ -1710,12 +1728,18 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> +	bool multi_msi;
>  	u64 trans_id;
>  	u32 size;
>  	int ret;
> +	int cpu;
> +
> +	msi_desc  =3D irq_data_get_msi_desc(data);
> +	multi_msi =3D !msi_desc->pci.msi_attrib.is_msix &&
> +		    msi_desc->nvec_used > 1;
>=20
>  	/* Reuse the previous allocation */
> -	if (data->chip_data) {
> +	if (data->chip_data && multi_msi) {
>  		int_desc =3D data->chip_data;
>  		msg->address_hi =3D int_desc->address >> 32;
>  		msg->address_lo =3D int_desc->address & 0xffffffff;
> @@ -1723,7 +1747,6 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	msi_desc  =3D irq_data_get_msi_desc(data);
>  	pdev =3D msi_desc_to_pci_dev(msi_desc);
>  	dest =3D irq_data_get_effective_affinity_mask(data);
>  	pbus =3D pdev->bus;
> @@ -1733,11 +1756,18 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
>  	if (!hpdev)
>  		goto return_null_message;
>=20
> +	/* Free any previous message that might have already been composed. */
> +	if (data->chip_data && !multi_msi) {
> +		int_desc =3D data->chip_data;
> +		data->chip_data =3D NULL;
> +		hv_int_desc_free(hpdev, int_desc);
> +	}
> +
>  	int_desc =3D kzalloc(sizeof(*int_desc), GFP_ATOMIC);
>  	if (!int_desc)
>  		goto drop_reference;
>=20
> -	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
> +	if (multi_msi) {
>  		/*
>  		 * If this is not the first MSI of Multi MSI, we already have
>  		 * a mapping.  Can exit early.
> @@ -1762,9 +1792,11 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta, struct msi_msg *msg)
>  		 */
>  		vector =3D 32;
>  		vector_count =3D msi_desc->nvec_used;
> +		cpu =3D hv_compose_multi_msi_req_get_cpu();
>  	} else {
>  		vector =3D hv_msi_get_int_vector(data);
>  		vector_count =3D 1;
> +		cpu =3D hv_compose_msi_req_get_cpu(dest);
>  	}
>=20
>  	memset(&ctxt, 0, sizeof(ctxt));
> @@ -1775,7 +1807,6 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  	switch (hbus->protocol_version) {
>  	case PCI_PROTOCOL_VERSION_1_1:
>  		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> -					dest,
>  					hpdev->desc.win_slot.slot,
>  					vector,
>  					vector_count);
> @@ -1784,7 +1815,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  	case PCI_PROTOCOL_VERSION_1_2:
>  	case PCI_PROTOCOL_VERSION_1_3:
>  		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> -					dest,
> +					cpu,
>  					hpdev->desc.win_slot.slot,
>  					vector,
>  					vector_count);
> @@ -1792,7 +1823,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>=20
>  	case PCI_PROTOCOL_VERSION_1_4:
>  		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> -					dest,
> +					cpu,
>  					hpdev->desc.win_slot.slot,
>  					vector,
>  					vector_count);
> --
> 2.25.1

