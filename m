Return-Path: <linux-hyperv+bounces-6121-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C0AFAA1E
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 05:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E21D1892ADC
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 03:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868322655B;
	Mon,  7 Jul 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IPGEVUza"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2011.outbound.protection.outlook.com [40.92.22.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46502264CD;
	Mon,  7 Jul 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751858104; cv=fail; b=UiMsPr2ZqyHGun80xTDCMtVEHUPLo4tgK0CwmqqpUtcE3JiaRe8oYAjhPY1DB7QVl7pJqZEnm1H5d2RMut3zBCqSxD9XAdXAmYnXJ4hRME2NFwlR5MJe7qzUgZ8ypwB3L/7pL2W7QT4ldCChMRXbuJ9yeQG9voWoK0G2wAtayGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751858104; c=relaxed/simple;
	bh=Anq/1ytGl4Z1CXsZJigXXlrO2GcDSfBuhytq3hG3PkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KN6jvnW8UOgDSTSCEPpp8tQLW4qvN4dU8QUdt9FHQJ9xzF4v8ymv9aPyibwRBH+TguyqdrpJdAns40YJWTDhFXLmj6Y4srESOZgD7ww0FOL7V17YYGyAhvRe9VOg0TMw1L8Ckj+g4mdon1J7Lvuh2tNPZq41LQfgnKz8Hs3I+go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IPGEVUza; arc=fail smtp.client-ip=40.92.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSiU0P6ND5fz21O8+RJXIu6mgeiaEUy3QH2ygMisQNV0LLzro7A0AblzTaJXYp0XCXwWAWsgX/6dSvpxoCWZfdQ9jIZT5xsLNXHxsxNT+kH+Xd2pEaCHAaMeK7hTs6dF7/J9uJIP1f3BRZE2CYv2Etu7FSGd5pp3v8UGm+PDO7JY0lWXVUKFDph2Lczw0g9j//ZUq+Bzb+Szt5sj7kYZazILev5+/8hkI1JSLvTD+9LoruZbAoGJ17K4HTKmaTtnfmyZp9YEWqgpPOddAxc0podGa83OxFCJ/ZgQgvF/p68FyhDU2LH+H17Neq3q9c1uhyo1Nb6BOPwI13nDTTqOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcO8QLIypgKyxH0bxVKzrYq+JbcHld8D2VN/MzNDwl8=;
 b=GG3O1to0sd59H6oigur2tBOCFDRdcignTuZDSc869eUbeP0jxdLjFao9R80oo+4z1GPMqB57YmG4mf7b0Ib50nGRrcsDQgjs8TuGX7hgoQKj9jQDRmKFetq+0N2lU3aT3INbIjC/5cqLlplC7+j46UildIcRID1bCQFs4Zn6ouXcAL+Df9fmw7lQvn0JGuWU2zkUwHbw2GOtu8qXz885cnQB6oeJW521Q8D96c0OAXZYnzUh8F7S2sED8oGY9Dz+Lg48dzcvEqNvqOgmyM1nLXPY47amzbGd6BT4c82LnHr7ZJr0/3b7hXbrkQN07SY/GcoZcer8ZukHw4CmYIB4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcO8QLIypgKyxH0bxVKzrYq+JbcHld8D2VN/MzNDwl8=;
 b=IPGEVUzab6SA6cAIKuPWsHkORb/KqmgtVviisdAPajQXXzyLICSRetvoUNdo1lWppfZdSGJsXVmPqd9aIJPyu+/iHjt6a+WUWlBuXi1SUqoVomBv7gSLa3zVmAcN6h0EFWOXfraWJFwWPgF4PwHBYUJ9Al4P/sD6iAy1N5YTPJa+kQ5sbh4UpClvVuNnaUe0IWoNfUURhUEkpMuPhUWq1lhNuUuU5154d9Uyyhib7JydanpbMTexnTuqL4Ba4cjHaTaQNGxnToAIyMplfonmC2nhA5I2YlTW6J5OhAx6YWBYB5xnd1FVRLtCl9XOD8Q/Z8dE9gsfFo/eTtKPFqusRw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8543.namprd02.prod.outlook.com (2603:10b6:806:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 03:15:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:15:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH v2 6/6] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
Thread-Topic: [PATCH v2 6/6] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
Thread-Index: AQHb7GwZPffbSdf3XEm7nF8dQ6XbXLQkHnZQ
Date: Mon, 7 Jul 2025 03:15:00 +0000
Message-ID:
 <SN6PR02MB415778476C69E61B7103D63FD44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-7-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1751582677-30930-7-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8543:EE_
x-ms-office365-filtering-correlation-id: 9e08b0f7-b5c2-4627-e8d4-08ddbd04754a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|19110799006|15080799009|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9hpcD9LdUW6aCTTjzMWPvZt2iVWjlyN0EcV/8R98LIWxjJQO1E/1OcraqVx5?=
 =?us-ascii?Q?OAGPldryNLk5RMKVRB6EYabnirQvDdItcCahfWcMTFC+M7ek3e3rRvacczR7?=
 =?us-ascii?Q?/p6mdpjnzyn81t4cIsTkwGr/9u6GuFUq92pBu+4olFuRt9uaHTftqltGvjOu?=
 =?us-ascii?Q?9IWpH5I3TouwGFneM1lTNHQdHMATZuFWDaHBMUUZP3p35mRLvn+CnYE3Hh6u?=
 =?us-ascii?Q?Fm1PtQ4e0ZiHStXyTAfqzoqW/8Jznx52SljMiir/+PbX3Ni9hgQsgAykyKm9?=
 =?us-ascii?Q?sNxMrN7NhmFlR8iysA8bflSZ/1CCVehntjKINFvQk18enYpwBEjX7eByGZTG?=
 =?us-ascii?Q?5cOTq9ZxkHQ33CszzOO0V75h45ovObAm3drrPdiyAC1HQqZLn+ZsWfHfp2HJ?=
 =?us-ascii?Q?DadpN1ikJ+HyKl+sJoUsLCfV2IGbCIJX880Dwo2Vho9ZjoIAR4k0cHN/paef?=
 =?us-ascii?Q?XuU5hqxhn085SM6cgytCRoXzuV1glpfcBsNYkeeLhIKlofugwl2aI28YHmT4?=
 =?us-ascii?Q?6hIn/EnJyVUlVknEk+/6hwEbfwFiZdfPayy22XaWa9DiCxfN99R4KeQu20aK?=
 =?us-ascii?Q?pNFMKXaB/QDMNZyvrHltU+kbgsjP0T0sk5sc/SMp992KkBTHqfCX16s6uVAl?=
 =?us-ascii?Q?LlCMfpt++9ZTnYNjEVHzBJeRud5A1yh7hK1hbZi1eDuEDnJUohJt4sNwg8Qz?=
 =?us-ascii?Q?QIFLjXJfy9iRu+TCfvxG1dzxDyjHUYs9WS0IkEyL2Dk8ltOtCA9kf3iq4w+f?=
 =?us-ascii?Q?66/TqmF3gFrO9nJ7hLJWUv5pjKd4VNBDHvSUezkn5rK8+J0rz4xOqK7GNj/J?=
 =?us-ascii?Q?AGreAUjtsfDv8P/3bZJ1xUJxZ+hULJQaE+yRjIayhUNoDSLae10Z+t5P6LWT?=
 =?us-ascii?Q?mbtUNrmQJ/0/IL35sbi2UWbHPwQS5bTrQd+iZfH/5zjl5pWXcGrfvpnrzTx8?=
 =?us-ascii?Q?eVlLWz1KlSRKFqG7W3Gr4WUjxg2VQld07omrHaxMzYaCKx9oova9sz2frNJl?=
 =?us-ascii?Q?7A18c5UhyhoPRtxpcabNySGeVvyXQuRFv/+u9c8padjgMlP65J+Kip/8Loey?=
 =?us-ascii?Q?8nvxn/mp1/VOBRq7QFcD/TRYf9UwOqAYqPgPYpB4zaudDhW84xuMhL0tuu26?=
 =?us-ascii?Q?cHg9rGdXUirz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2XHE0tQijw1KtjKGi9A7gUUIuFDPVLXRh7HeBGrAB1Bkc1XWMZmXEIGPcJLH?=
 =?us-ascii?Q?Ycj8hK0vH02nLPBOuVxZjD64s/INfxtU5WhiC+D+PCmryniAgWioulZ1Nx7H?=
 =?us-ascii?Q?DbgjqtVKfizph/8ubaoidnJNfTyyCVbmgzOFR1xhtTw0fmyHp8aE/jtT6peh?=
 =?us-ascii?Q?kKx8WgCph8nYybQWrjOH5jzUfugYQHxt95UYJyDXb3LLDy96ACFiV2R15fpN?=
 =?us-ascii?Q?yVjVyYU7erAruQhzaQyK0mOyECDAGsLYu/GEIt2FNkDMrY8sBnAzapzIOfuN?=
 =?us-ascii?Q?6xlIN6iaQ/66gF3CZ7szgciif5WsR6x5BfSr+WfCqQRO684x0tCxc8c7UktK?=
 =?us-ascii?Q?0pN1QXJaYajLxFP10bZ/UBZcS8AZJn1VEvO10rMYb0g2YTSarxrGFeRNjJLI?=
 =?us-ascii?Q?bABBJmCoLOR22bMaykY8+o++HLH2ORHGdX0twooq4jIomO/8LlfgecsHnB7i?=
 =?us-ascii?Q?fu9ekNV9AuUqNboO6ruTpLttgTdkn9hcrIMme66JgYupmt9lvr2eGwZj6J5w?=
 =?us-ascii?Q?uw/vaGnJ9NInuOI3vr0aUIq4tTrQpJZixyFXSXBTVD3YHkdI9TLlSA2t6Va+?=
 =?us-ascii?Q?JD+ivn2ZhivNdhF7Ox9iVuo/f7j2VY/a0sjT8MsJxe9h6aR3JXU+Y6mh6GuK?=
 =?us-ascii?Q?VMKA1RCUQEX1gHxhcTu4hFpWNcJoCtljBxRSuq3If1MioINqK1Hg4MRvNnpc?=
 =?us-ascii?Q?ancZzcvyzRH77MP73yYchvVSElj8obdzvJZn5W1lygXh1HWY0Ysd/Q6Omb5E?=
 =?us-ascii?Q?ws6oY9l6XuStB1XcwcN30GvHJLJPDsCIEMQplG4mLMzIoNkPqfRw3GDYQ21H?=
 =?us-ascii?Q?FFxgsPu/HUQ2BoyKLqynD+LEH4V7izDs21tdfNiYrta5Ij2A0K9l92KJrSQG?=
 =?us-ascii?Q?Dq2Z1VlSeLHWroUR2gJ4Qn804FN8vyirXKcmJK/p3qBCCAZVIsQnbixTRJIu?=
 =?us-ascii?Q?O7u/4dN/dCYnsZtvSD76y8aBbJQ5R+sfRlwLWeJLG4XN5XmPh4Kr9IHcOnmn?=
 =?us-ascii?Q?w6pxqeSOXbhuMMh5zzHD/9CZYMbNjikPI0OygP2hy7jL/kOLQEAaC6/1EHun?=
 =?us-ascii?Q?XobO5ccBDt8KDN05KN/PyqaZzN5TQfPQAOYLCqY+Qs3ZJU1Wf/ek8uNfWIkM?=
 =?us-ascii?Q?y5360TeXF3D7sAfNho59LcXRdyPwXV52RtseGZLnPy83Mb18yOHb9OqvOpW2?=
 =?us-ascii?Q?vQubuE+ph6CJj9gqzHUk6Y01Bu34O3jJz1FpMknLa0/XMMgQYl8V3tBkElI?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e08b0f7-b5c2-4627-e8d4-08ddbd04754a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 03:15:00.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8543

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Jul=
y 3, 2025 3:45 PM
>=20
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> Running as nested root on MSHV imposes a different requirement
> for the pci-hyperv controller.
>=20
> In this setup, the interrupt will first come to the L1 (nested) hyperviso=
r,
> which will deliver it to the appropriate root CPU. Instead of issuing the
> RETARGET hypercall, issue the MAP_DEVICE_INTERRUPT hypercall to L1 to
> complete the setup.
>=20
> Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().
>=20
> Co-developed-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 4d25754dfe2f..9a8cba39ea6b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -600,7 +600,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_=
data
> *data)
>  #define hv_msi_prepare		pci_msi_prepare
>=20
>  /**
> - * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> + * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
>   * affinity.
>   * @data:	Describes the IRQ
>   *
> @@ -609,7 +609,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_=
data
> *data)
>   * is built out of this PCI bus's instance GUID and the function
>   * number of the device.
>   */
> -static void hv_arch_irq_unmask(struct irq_data *data)
> +static void hv_irq_retarget_interrupt(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
>  	struct hv_retarget_device_interrupt *params;
> @@ -714,6 +714,20 @@ static void hv_arch_irq_unmask(struct irq_data *data=
)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
>  }
> +
> +static void hv_arch_irq_unmask(struct irq_data *data)
> +{
> +	if (hv_root_partition())
> +		/*
> +		 * In case of the nested root partition, the nested hypervisor
> +		 * is taking care of interrupt remapping and thus the
> +		 * MAP_DEVICE_INTERRUPT hypercall is required instead of
> +		 * RETARGET_INTERRUPT.
> +		 */
> +		(void)hv_map_msi_interrupt(data, NULL);
> +	else
> +		hv_irq_retarget_interrupt(data);
> +}
>  #elif defined(CONFIG_ARM64)
>  /*
>   * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leavi=
ng a bit
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


