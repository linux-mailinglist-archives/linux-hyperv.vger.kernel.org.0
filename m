Return-Path: <linux-hyperv+bounces-1551-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641C858A3C
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 00:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626EF1C20DE5
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A414600B;
	Fri, 16 Feb 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IbMDjIxa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11023014.outbound.protection.outlook.com [52.101.51.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506438DFE;
	Fri, 16 Feb 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126859; cv=fail; b=SIWrB1bk2/fIiNodwVbnZEnrhD2mn9JL/GfTkafNSVHsQsB2+p3aTqIIMz9eC9ALE6jcQmKkJhk2NvD1P30rBNsOq48fIkCkXbncXbebMtrb6cYtIQBzoB/hFKu7G9ZmrBqK5g2TI6nBzA34VroVrwrOcItVa5yHH1x1UpeuHfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126859; c=relaxed/simple;
	bh=KI7Ycrrk8zIk52zMHdd3eufJlcDNvcLr+LqoUdV+avE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYbdEYnRO88MQqkPJvsbu+nJfWRtvxmyhSv9MieN+CjsqQ0NM9FgYQ2VrIcmHwzb3S1Cwz69+e7zLlCfxcrx8khY+1LhHrTJTpn3+bjBYhht5/5lclYste6IbdjFofQKls6WVnozCWiBcioVAK500ff38iANQv1smz3o9x70/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=IbMDjIxa; arc=fail smtp.client-ip=52.101.51.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCsEeFeIHoFY1p94wYFANvNA9gyLhUqJmMuBZ5P0Jgx+oBKZ/pOdNF8vc92UKZ/pEVofq2pJDVj3r2RmBYGp3mQ+OVJhFC/k3viGTLzl5731+FkZbMqKPwWjxGySxeH2ipI+ipjFIvhzDO6nksvLClJof0wEshEmN+ADyL4HB99By+cu8Jx8OGZNY+fNy1h7D9Cjw3FQsC9MoR8qyodMeoIr71Kdb43KRDAMrCsLRQM4SdYSj5IDhnDBgSdPS2hpS6KY3whmPoAGJmFcBp3CRc2Qni2zdILEib1TLVPhYB6z3iA4thuumMRB0gyZSWY/35fhgyVWTryy1F0EwnLzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW1RAlc00oRaHiYFjsBvXWHDnN1vLYFzyhN/BNPp2Mo=;
 b=C5MX1zx3WXCoQdYgD65dkJlZLkbVATaH/tlbdgegqEbCmwx12Jg54Ok3YshxcgAZgScqxzl7gkjrx+jVV/yvv4xaTr9paSqzVHmSbGR03W04kJ1qdFZkFq6SdrfqFWUH3rQQE760i6xMQ4M0Ay5EDJE24pAVu2dUc/ux4phSrWgNZr8plGQtC/7OWOhsYz6/OMxPChKxdLsjzlugvTyChvfbLuMzXDPD33l2mkV0b7/cH8tWwFMd+dQp8o4RnZZ7JHYvWKBpN8aZgch0LgND+mv0vkVx9LQWATWXegbuTwCl5+TlvU55hjKAXlQ+Vb87hpZaR9JFjSQomfM3rORkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW1RAlc00oRaHiYFjsBvXWHDnN1vLYFzyhN/BNPp2Mo=;
 b=IbMDjIxawl2vMFigt9slum8eKSseNYUNVvn2ByxrdX/gmjRB2Ws/S92Ik6p7vuFFGMNCJOUj8Q2EhiXBvMtQqA0WMywP34UyHEALmxsd/jfTitMb3PXsswsoWGPg/t1sD4DPk43L7BNBc4RdX1NA39ZOP4Va5C7LcNjWi7bl9/Q=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by IA1PR21MB3425.namprd21.prod.outlook.com (2603:10b6:208:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 23:40:54 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::d1ac:9334:3cd9:f655]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::d1ac:9334:3cd9:f655%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 23:40:53 +0000
From: Long Li <longli@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] PCI: hv: Fix ring buffer size calculation
Thread-Topic: [PATCH v3 1/1] PCI: hv: Fix ring buffer size calculation
Thread-Index: AQHaYRXzjTB8TuR+VkunGT/LQRsXB7ENoK3Q
Date: Fri, 16 Feb 2024 23:40:53 +0000
Message-ID:
 <PH7PR21MB32639EB1823186397BFDD78ECE4C2@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <20240216202240.251818-1-mhklinux@outlook.com>
In-Reply-To: <20240216202240.251818-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4109438c-1514-4254-a01c-bdefbe1b7fb0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-16T23:39:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|IA1PR21MB3425:EE_
x-ms-office365-filtering-correlation-id: 8e1073e9-ac5c-4c35-fb2a-08dc2f48b732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KTXxmUey3xN5wxUyQBBHe3PL+r2m8qKG5t2IqbLNaK12eH7SVIuzjG8FzhdsN/QM6H97Gp98ujL6Lqpziz9C1ytA52+j/VjIEykl4hJ0RzGTunsn7gydmKDG0C2MM483TDMSd/tCh1/hWPfyOBkGq8Y6KYW10f8VAp0Z/RbIrpoUsjvoWPjJJtO9KrrOBF8ZhV5dLf6qiNsHjBAB5ItUOOcaNMNtYWszW+vUm4Ag/HX1Iw/zvu4b/yzEdxUVCMXZro5oBv+TYi1hB+fSxactg0gWgwHh1wrAvlgBI9WSyi19vZNI9e11pQ4rLB+RO4fuZN4q25HrH5ZN4BPMXIQFM9LTiod0YOhgAjSRyJR2w23WhiW/vfATmV0xRiegoA1UnyfekHy/dR07hzpzrCF6czoRQR3M4Q22D+i6p0moLSPUb94DtIVgbjRYS1Ud/qLPY3dH45peGsbS1anDMsOE31j2lt73I5zum8e306jmUbz1bNhw48fThwm2xW5CGougEtY1jBa2BLtLxprSdTeDQZJ8y5t2IInvlysZgXKo5vkmBAtNBPGZithu19tdCiSz4oPdmOoUtXc/f/sajDL+IsnoDtIdScSo0yKN3yOK0jJTKOyvdlbHTek0aCTov7hpOBrAfGwXu47y0Rhe0C2/8g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(921011)(5660300002)(8990500004)(8936002)(2906002)(7696005)(26005)(8676002)(66556008)(41300700001)(38070700009)(478600001)(10290500003)(76116006)(82960400001)(33656002)(82950400001)(83380400001)(122000001)(38100700002)(86362001)(66946007)(9686003)(66476007)(66446008)(52536014)(64756008)(6506007)(71200400001)(110136005)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ng0RkYbY27AUfje3yz1VlzKII7iUOybExZK91eBdfRrB7zbSbjrDgq3A7udp?=
 =?us-ascii?Q?awlgFrjvD6xBUC8aoXqBfEcGbRO+eeyf7/ZIBfDUTXabQ18GXAg8tMkZb1S8?=
 =?us-ascii?Q?LH9Ji/BHsqmuESzMh/0kWY8OwVMRVMoCrs0vDsAsAR4fiXOYnyggddOB94gD?=
 =?us-ascii?Q?13TfIL4jRGzMriG3sKHDlOptlpLCek2J0kBKXSP6QYSdkDlzAkkm3h8gAnxQ?=
 =?us-ascii?Q?R795JTIoizBkCoLUx+JqfxBiIoRQyqZ+Q4roXWTv86LweATAXlzh8qKBb/fI?=
 =?us-ascii?Q?alXBraSh5gMa5BrfyWfyLK2iqzSgBip9a+rFMj6lSGqhYIo9MXI2LaE+gH+Q?=
 =?us-ascii?Q?QgLbfkI9Z+y3bCAXo12oEX7ACQuMBNrXYft+3XcXaFQ8VPC1My1JQOL53DFl?=
 =?us-ascii?Q?0u+7OVPW8f5sZfw/ysGF//Atl/JfY0vWMwIWlVVw98qurcrna3uFsQsY6A3p?=
 =?us-ascii?Q?2qrtEL5+VNi+UJs4hkfX2FkBCJwEBDtFwGaQRootiMSB47Ou/c61dNkhBix0?=
 =?us-ascii?Q?ijHPJhNNDC4QzZKEI3zG+RRutjD03i7NGzLtHXoeCyDvsQdheCPkLlijsCRe?=
 =?us-ascii?Q?EpkFSYREtK7rsLGnvSdUYlLw9++g5GgHwD8+ixLhSqwD/p6B6KzrWL+qpOkb?=
 =?us-ascii?Q?8Gr4RnbDALFu3bXjZZJ5us2VRDrvCs7lSUUTZ09Js4ZMoE2KruZuzZUgB57z?=
 =?us-ascii?Q?rCq7iiUl9jgoY1zit7so1gKUe80T2Pyou0t0ZNyBOc3YfKbL8sDHunscVa2C?=
 =?us-ascii?Q?EKWkY79Ccj+KnbPRH7CTAcslxWwvjLE4L3ujerRwV6v87bzzOq99/AoN2Ep2?=
 =?us-ascii?Q?khdgNlidcHZXmzd/pwHyy+yZk1VFFW+b8261qIInFm9O5RMUJJC06E9zOdT2?=
 =?us-ascii?Q?XzkB892qj7NEHop0p5tOLkVuCuaPBFIRlmttKLXfS0B/HffcZX40VSsVmp5l?=
 =?us-ascii?Q?ATHq6bVDw+PFElGX5xyhNbae0KnXYC1SnKQliq0c/8CqK0lP+UiPhtMIInS3?=
 =?us-ascii?Q?fZt+FznVRFDMKvgn77ueaMTT4Qd6Ya2l433YSRtCLqCEw2aSAzPBigepi2Kc?=
 =?us-ascii?Q?qGNNNCfcd9v/gSfGk2d0809ryxc5Iv7VHjpdvXUMXbtiYIPL2fTbBMyQx21B?=
 =?us-ascii?Q?VfGha22EN2IH/Ex91QvE+PvuriyveulQ1C5nYjCswxScG8WbygU81rgl2Nyq?=
 =?us-ascii?Q?HOgQGSI2lgalRWIkTXlPCSlROLusHS5Zauc3ruLUEKhM4QpKWufey89oP6u0?=
 =?us-ascii?Q?bOCHbimbPlXXzFkFI1z1wrJ9g9EOh/96soX8+XmaiSe2jV75sOna+87okoKx?=
 =?us-ascii?Q?R74cEsotkKbS1lmPBjAdcSesCmjyaC9lKszmbCwjGAebS4ghBANM1qYLANp6?=
 =?us-ascii?Q?wGLFVSMG9499Ej8CAYFqQB0RjETTimEwttHrroq1fLRd+pk+qD9HlhMK+gF1?=
 =?us-ascii?Q?1+6V9K+kHLWQRqFNFuzeDtR1J115op99KXb7YBL28JTI9+pT1aDcttOUt18e?=
 =?us-ascii?Q?e3zyKvU6Lgwe8zuYx/reYo78cGxg814HZ/I6rtl3CPkGRLoBntHSiByAOQQq?=
 =?us-ascii?Q?HflSaTneywoeIugSipVITjTcU/zpM8GfUa4XfSRc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1073e9-ac5c-4c35-fb2a-08dc2f48b732
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 23:40:53.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ihRLokB0fkeRVS2XklL3RAk2sDX4Cc8AMYUHUljphpO+J0a6MJ2FY24qtIqQZgm2UMBWYV625MwrEt22r2aKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3425

> From: Michael Kelley <mhklinux@outlook.com>
>=20
> For a physical PCI device that is passed through to a Hyper-V guest VM, c=
urrent
> code specifies the VMBus ring buffer size as 4 pages.  But this is an ina=
ppropriate
> dependency, since the amount of ring buffer space needed is unrelated to
> PAGE_SIZE. For example, on x86 the ring buffer size ends up as 16 Kbytes,=
 while
> on ARM64 with 64 Kbyte pages, the ring size bloats to 256 Kbytes. The rin=
g buffer
> for PCI pass-thru devices is used for only a few messages during device s=
etup and
> removal, so any space above a few Kbytes is wasted.
>=20
> Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
> Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer head=
er is
> properly accounted for, and so the size is rounded up to a page boundary,=
 using
> the page size for which the kernel is built. While
> w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
> 64 Kbyte ring buffer, that's the smallest possible with that page size.
> It's still 128 Kbytes better than the current code.
>=20
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
>=20
> ---
> Changes in v3:
> * Add #include of sizes.h
> Changes in v2:
> * Use SZ_16K instead of 16 * 1024
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index 1eaffff40b8d..5992280e8110 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -49,6 +49,7 @@
>  #include <linux/refcount.h>
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
> +#include <linux/sizes.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -465,7 +466,7 @@ struct pci_eject_response {
>         u32 status;
>  } __packed;
>=20
> -static int pci_ring_size =3D (4 * PAGE_SIZE);
> +static int pci_ring_size =3D VMBUS_RING_SIZE(SZ_16K);
>=20
>  /*
>   * Driver specific state.
> --
> 2.25.1
>=20

Reviewed-by: Long Li <longli@microsoft.com>

