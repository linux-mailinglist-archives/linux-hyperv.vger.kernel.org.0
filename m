Return-Path: <linux-hyperv+bounces-6134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F3BAFBB1D
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 20:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155A217BFDF
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A9233133;
	Mon,  7 Jul 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a2sLvREU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2059.outbound.protection.outlook.com [40.92.42.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF5199E89;
	Mon,  7 Jul 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914147; cv=fail; b=Qr0KIkxdLVJqA6y2vG8WCVSIfxZP8qbGEz0kjb9DKiSWNR1QWDOZ66HZwI9cf9eqWgJHuSlF0s+teR1e+iE0Jm1jGEVpKORFgxyto1xsXTYmKNBDcGLfZol4GBZZz0hke7xB9n/BhJT0mFz+a0TmoC5fIBxsFJOFzjRRtWWiSX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914147; c=relaxed/simple;
	bh=yHeZUTuTqfVjqNmhUCEMwu+JE8Wx3ywe3DXepEDIXLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HuODuqVBP/SUR75O9BHlvUzZWEJv+CKVxXcoOoDf5+3IM9+WRP0EdJomXAbXtmQSBXCslBcMOhnQlyEi4lSbAHv4HZcgDMQWIYVU8VLSJbFrUMU1Xgg21Y6xUbQ3wHvwtow5KoFPRo0pdrCNocbTfPlh8yWAjz3gnddScaqMMUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a2sLvREU; arc=fail smtp.client-ip=40.92.42.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg3TgCNZfX+71EEVGltswvFnAN4IYt6DJaNP5xbEHvwORQyIdTwZ5INotxpbh9el3/KKwUU0A3gjhyq2rxeiWx+ceL1Eghy08DLAtAzDAB/129ZWTwHMnbtqQRpIDBPI967bccwUzzO5aTPDnCrtOtx4zFDsuxbw9PLuU9arJ+LKS3HSOIMZ0CIkSr3NUaeqzjMRKYonbo1eB9disQ3sWcnHHVJJSPJZxQq36qvv5GSxqWSuaFRFYU9JH15nuZjDVLFBmIPG3IX65zevBRqXeqtkGxjK7o05JM3433P5uNARtKs7gg8mY6sfvVReQwknJo+IW4LI3cCTi64EdP0N7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kSvKRL+6sADdx44ORttc/0mwM2YZk9r04HLkqfUj48=;
 b=u+N2C0Fw2PgjCG6YKZeA4SiM61DKtUKJoGNhnH1whw4eeDavWhtQ09SiEDPYfliFgAvYHtmSxIhr3iXhnZQSqu/O2Ag/YG7YUMz4okpWVFy8YZxMOKyOqE7oJRzjmM3rYp0SsYdhcfXub618ZvLWBonHy7XpZvgRoaaGFvQrD4Ol7QajY7oSDo8VLlqvZKnvAkUk8XZf3X6p3ReM+DWR5PZDeEOyLiRCIDgFfWDnM0CsFJX9EO2n2Mv64quE2dRYBv5+JzKAcXRuBcgQilUdraGlqb/7R4bapUBDjRgaWovjBlJm3NM3WEmvtPTWw5rVx4Ig7q5FSzJ84Np6CPmWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kSvKRL+6sADdx44ORttc/0mwM2YZk9r04HLkqfUj48=;
 b=a2sLvREUKgjDdN7Te/pDJfrovJqKfLY3CHl88yb327aw1cXKr5L1+5NjLneFcT7uniCgVYKZyrGeb22VypG3GDh46Mye5xr0vqCayF79EH4YutbzUocJ32vOhmxmvm3itw72utw4hYnA1RBGUOvJ8EJUKe6F0mj4vsUXyK2ZaKlz1TjXfSBiJsqQGvrWn8hGlMWxVTPnJa6nKoeCWAibMqx8C2KYWPoyhHubjSFUtOeJDqok206Sak2XKAljd0EzgRz8VeipoXGKkYooqj0cEYB97Ytyu9GUK/+0aGYjByWmN3XWqTu29lfPuuJ2vmcaVfZ8sCW0C3+Sa7OgaTgm/Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7281.namprd02.prod.outlook.com (2603:10b6:303:66::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 18:49:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 18:49:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH for-netdev v2 2/2] PCI: hv: Switch to
 msi_create_parent_irq_domain()
Thread-Topic: [PATCH for-netdev v2 2/2] PCI: hv: Switch to
 msi_create_parent_irq_domain()
Thread-Index: AQHb7xf/A8zJRWFEyk2mZWYCCrZaYbQm/Dxw
Date: Mon, 7 Jul 2025 18:49:02 +0000
Message-ID:
 <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1751875853.git.namcao@linutronix.de>
 <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
In-Reply-To:
 <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7281:EE_
x-ms-office365-filtering-correlation-id: 6ff331ba-7351-4b1a-249b-08ddbd86f12a
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6eQGC/G7Dawllljy95FzHWbT6yKBgT772Qf4EbSIkMHVgZofVfovKAhCHDZdJTGdkTPxGHPw2KhmPOxgYuf/Kri8QzaqRVzrPAHXF2gAas6rQbRNJVAS1b53DHY3uY7252gSXlu8F5+/LxErT9+AEOo/lpw9xkvZsjjdiRxLTVURClwAVWzMUmPRUCWjRM89wxtQBZz2Pscvh+RreN1ETeXPc/XfmEOQv2PfrxrZdwlueiJ45M2PRDQzVRyN/taY88KgmXEC7v5tiKJVmfUhqMsztCcdypVRHTVUf1EkmZduuKMrC3ydb7+jxS1WjTyzswSv4JkdBkNPrHUFeckU/a+SwnavW6+WVVoOcwO6q29AFS/osfDwv2Lx2isnRxwi1gIlm6YigCHBRRwRAV8IWmCJQmKMvW1Y/dXplU2k/aFqQ990UsUNRIsKdfSZDDGZ5fUjs+BfuS4Bw1r994yJ0REdkIVl0KMJS3q5s25Kl2uBToN2w5ojsG5sxn0qiorQznYVaD1yq1N1AFEQwRIsI5hqJjLGsvC1ow1ID2+ME0kneUXdcqA5HVMv4v6px5w3vaB6aQ57Hk7+cnKOOYzpp2Xt3PP0y2pocFT2hMWSbP8k8LONixKFrFZtEhRjHWMG1JvTW/vVwJ70Eb0KRl4+y6EFOv8+hwrLjRwqVQc+G4WyewDjRTz+Rm0cghtWp6mwY9x62KWQq4kNye5EGF8JbfVAV+ILHsJOgAIyC7zRa6lVO8sEm/hvjrg+p45JqFbm5A=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799012|41001999006|461199028|8062599008|13031999003|40105399003|52005399003|3412199025|440099028|19111999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?klzeea0quABvrQ6R/F2qHHntAGDj5ui1xgzYeZI12J/8BdewfhpkWdPfn7ba?=
 =?us-ascii?Q?LNiHvtJGgRApxPLz/lHwhkfg7V3+fvIWh4sYXSZDVkXSgiNmlRPMGdnkBc+R?=
 =?us-ascii?Q?3LwNsVlyCmAlGW7CUbKcbulbIcHhqBmJPBJdjbsi/CNMNEnjau1Wye80gvxK?=
 =?us-ascii?Q?rak9iGU4tb1p+GR3ldN/Hdu7UnfJaOEeTnVe0wsGoBNUuMGn/DHbGfbLjccB?=
 =?us-ascii?Q?xy+pn8PIiic/qkVo5fOaJtyWmSgonAbId+xiUnI6AT/CApHH89tnFcen+WVp?=
 =?us-ascii?Q?vlornUPGqeg0VkHkXdGrPz7eahJUEW1BP9JmofdWtuqvUeejZV74hpE8114t?=
 =?us-ascii?Q?3HvwoXd5Y3XEi2AFx0N/N6OdkMmanWP8mdUmOJDAsyusoQtd0gbSchgbAvAL?=
 =?us-ascii?Q?G9k33ACPIGCLy5tS4/WMUmCOkFGo3qie1XR1hybwISkk+ExycbjacUw44vdo?=
 =?us-ascii?Q?1y6kYYlxe8hFsMNqe+H9OwDlaeTkdUpFXlnqdtJcFy2p//Qy20j7GvLjcY4w?=
 =?us-ascii?Q?iuavLMz62Cj/t6fIUiB9aP78QzS/QzviJgqBsb+5Z1phZ1oPO3kOlaD34YA3?=
 =?us-ascii?Q?JU9VVDN9etLDrfMHhmq/b4X39NVhpmSHrDdSN8hnxJvUaUU+BRMwWpcaBtsk?=
 =?us-ascii?Q?Q+XDM1ci2qmbgL9UF7UIn1vVlGUQ10UY+WpQdET3v9vrXo0cAveBjm641wPS?=
 =?us-ascii?Q?75UT0ogNhBhbl+j6QOrhpANUfTaXeubOD2d3rdFH8c7QNY+HLxBFgeiw9v09?=
 =?us-ascii?Q?n2R/9fU5bIoGfGyn9rYLAbUv3UbwsMUgiUVsucpqgZI0/NJeqV6AdnrlP/aX?=
 =?us-ascii?Q?mKIYnTf7Z6O+cli7FpNzWZafXjKn0iqCTMpQAHi5uqGv+PqNzucaLLPpksdR?=
 =?us-ascii?Q?1OJUO54Sef0heciN7tBNWLAcWMhKPgVPKL86uao65Xdu4g+t8yeqCramL/QA?=
 =?us-ascii?Q?+ssh4xuXn9pROuC6cwbethS927ZgZRdtRl9IKd/JmCE9SRM5MeFa3leFyBKo?=
 =?us-ascii?Q?5McoggqFImMa1xHu2s1NGBBuQu4nv341DLH9iwCKc0XmM2zGCPDV1Ghgrshu?=
 =?us-ascii?Q?cJ75VEh9H6qhaAQgS5ltxULRvhnmB4GUyoYshhupnGxEO2WpZ+m6UKGO0sDC?=
 =?us-ascii?Q?fEcfNYKCIpb3MsjwSSdkT+DOhjfZvIQERAxp+3WY1kPcfNFVAf1PQiIPznu7?=
 =?us-ascii?Q?5yg6oY8XD8hx++WajrC5sQ3N1gQ1vjTy1UZQLg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?roMo70hx0Y8KSwteE3eclIuDUNGLY01GBCUoRvQDlYvifVGW9mSWW7870u+q?=
 =?us-ascii?Q?7wLnrSz/lUkMcNxbxjIqsOVBI8o2WjbeBLZYS01Ns3NOpo9W1qX+mVIF7qVE?=
 =?us-ascii?Q?aJ8r0DIilsXMfAe7l5CGDcRpUhFPfejOqJZZk+pWKaMlM1TC8u7mWaUVM/QN?=
 =?us-ascii?Q?BELWUR3uBlZ0mzZOLciil4JK7TDsQt04Y8a/1fE97M+l62HmgpJNvdWkC2K4?=
 =?us-ascii?Q?yC36X511lpDu6a/XBK8LXB4PkHq/TVlhcYrd879Thh76JW/BtD+E069pr8BI?=
 =?us-ascii?Q?mdlTqPD1O930nVE/NszWNepHdjZrCWoP8gOt+VqtgKu4Vd4w1BwEJO30eBDS?=
 =?us-ascii?Q?oQAuDXy1mE8fAoo4D6WUzTBMQDKVdR8lW2eR9/uTUVBSgKwnPoYoaYxH6AOj?=
 =?us-ascii?Q?RvR95h/Ie2JxNa5fBZNectWDaB9HsydgFwXhhiK/5ZwgBuMU5GsJHqr1O0gQ?=
 =?us-ascii?Q?D8IhTgiF9N9DL+q2bjbXhMQXsKcg5MGouHtByLa0nQL/xHJZBehjR5gWd7nQ?=
 =?us-ascii?Q?GY953Qvsgn7UEHk+qr2upPbgHhM1zH7dWrzU9yL6AWAk6x9MnFplfK7jARH1?=
 =?us-ascii?Q?wtkX7PFFPr8a8sJrTCGuehBhnDGB419CsoK0gaZOmjZSFJfnczm8DcDEU0Rh?=
 =?us-ascii?Q?h3ZAmMk5jziabhUnP8d484Bp0/27FvZxJfo8svptXIxg8b7mAAdWzX4tsoi4?=
 =?us-ascii?Q?aZakDf/ros9WqPUnEK58dUvD8wuqdgIfRfcwyKS4KJoltcEiG1yVk4HJV7iE?=
 =?us-ascii?Q?q4fsuIV+SnKDHI91TrMoDcCtXvQVbeBiQZDTM8rEpoNHYYRL0+UtrVDvuEyi?=
 =?us-ascii?Q?M7DCydOwfajSTOYINevATeeBcULE2LZ/a4xDSIJ3Aw2qxqhzN4I/MrlEESxo?=
 =?us-ascii?Q?Hg3RVZkZ2OGQr41X0g4CDcgLbVkYAg9px4elC+eIDKr9LfKVSy5Jlvyo0dBd?=
 =?us-ascii?Q?LJHkqQ3blfqggTPXB9AxwBtDA7GBzVmHr/vQSqzfzZLoe2prtH5cHRpSGInc?=
 =?us-ascii?Q?xGwnXnVXFsMjg6fPOPh4MmeL4Hk3yr7ZXHD/zLvm8T6rgMpV61DzpsbyyBaK?=
 =?us-ascii?Q?JmBRXAAkYf0mk2lZfTeUIF3dKOB49+5xUhXRO7QAZWLHu/FAoFK8hXi/7Hwz?=
 =?us-ascii?Q?LJh5h4CpJ+EZUeZaa04q4uyapUakIvyRbnCWFhrkjnvRyMAcciUZihpVL9Iq?=
 =?us-ascii?Q?Su2K2hRhlXMmwoEcacBBu/S1Kf6mllDnwjZWSL+QDeQ8RT95X4Eb38zkCm0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff331ba-7351-4b1a-249b-08ddbd86f12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 18:49:02.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7281

From: Nam Cao <namcao@linutronix.de> Sent: Monday, July 7, 2025 1:20 AM
>=20
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
>=20
> While doing the conversion, I noticed that hv_compose_msi_msg() is doing
> more than it is supposed to (composing message). This function also
> allocates and populates struct tran_int_desc, which should be done in
> hv_pcie_domain_alloc() instead. It works, but it is not the correct desig=
n.
> However, I have no hardware to test such change, therefore I leave a TODO
> note.
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

[Adding linux-hyperv@vger.kernel.org so that the Linux on Hyper-V folks
have visibility.]

This all looks good to me now. Thanks for the additional explanation of
the TODO. I understand what you are suggesting. Moving the interaction
with the Hyper-V host into hv_pcie_domain_alloc() has additional appeal
because it should eliminate the need for the ugly polling for a VMBus
response. However, I'm unlikely to be the person implementing the
TODO. hv_compose_msi_msg() is a real beast of a function, and I lack
access to hardware to fully test the move, particularly a device that
does multi MSI. I don't think such a device is available in a VM in the
Azure public cloud.

I've tested this patch in an Azure VM that has a MANA NIC. The MANA
driver has updates in linux-next to use MSIX dynamic allocation, and
that dynamic allocation appears to work correctly with this patch. My
testing included unbind and rebind the driver several times so that
the full round-trip is tested.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>

> ---
> v2:
>   - rebase onto netdev/next
>   - clarify the TODO note
>   - fixup arm64
>   - Add HV_MSI_CHIP_FLAGS macro and reduce the amount of #ifdef
> ---
>  drivers/pci/Kconfig                 |   1 +
>  drivers/pci/controller/pci-hyperv.c | 111 +++++++++++++++++++++-------
>  2 files changed, 84 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9c0e4aaf4e8c..9a249c65aedc 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -223,6 +223,7 @@ config PCI_HYPERV
>  	tristate "Hyper-V PCI Frontend"
>  	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
>  	select PCI_HYPERV_INTERFACE
> +	select IRQ_MSI_LIB
>  	help
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 86ca041bf74a..ebe39218479a 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -44,6 +44,7 @@
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> @@ -508,7 +509,6 @@ struct hv_pcibus_device {
>  	struct list_head children;
>  	struct list_head dr_list;
>=20
> -	struct msi_domain_info msi_info;
>  	struct irq_domain *irq_domain;
>=20
>  	struct workqueue_struct *wq;
> @@ -576,9 +576,8 @@ struct hv_pci_compl {
>  static void hv_pci_onchannelcallback(void *context);
>=20
>  #ifdef CONFIG_X86
> -#define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
> -#define FLOW_HANDLER	handle_edge_irq
> -#define FLOW_NAME	"edge"
> +#define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
> +#define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_ACK
>=20
>  static int hv_pci_irqchip_init(void)
>  {
> @@ -723,8 +722,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  #define HV_PCI_MSI_SPI_START	64
>  #define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
>  #define DELIVERY_MODE		0
> -#define FLOW_HANDLER		NULL
> -#define FLOW_NAME		NULL
> +#define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_EOI
>  #define hv_msi_prepare		NULL
>=20
>  struct hv_pci_chip_data {
> @@ -1687,7 +1685,7 @@ static void hv_msi_free(struct irq_domain *domain, =
struct
> msi_domain_info *info,
>  	struct msi_desc *msi =3D irq_data_get_msi_desc(irq_data);
>=20
>  	pdev =3D msi_desc_to_pci_dev(msi);
> -	hbus =3D info->data;
> +	hbus =3D domain->host_data;
>  	int_desc =3D irq_data_get_irq_chip_data(irq_data);
>  	if (!int_desc)
>  		return;
> @@ -1705,7 +1703,6 @@ static void hv_msi_free(struct irq_domain *domain, =
struct
> msi_domain_info *info,
>=20
>  static void hv_irq_mask(struct irq_data *data)
>  {
> -	pci_msi_mask_irq(data);
>  	if (data->parent_data->chip->irq_mask)
>  		irq_chip_mask_parent(data);
>  }
> @@ -1716,7 +1713,6 @@ static void hv_irq_unmask(struct irq_data *data)
>=20
>  	if (data->parent_data->chip->irq_unmask)
>  		irq_chip_unmask_parent(data);
> -	pci_msi_unmask_irq(data);
>  }
>=20
>  struct compose_comp_ctxt {
> @@ -2101,25 +2097,87 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
>  	msg->data =3D 0;
>  }
>=20
> +static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_dom=
ain *domain,
> +				      struct irq_domain *real_parent, struct msi_domain_info *info)
> +{
> +	struct irq_chip *chip =3D info->chip;
> +
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> +		return false;
> +
> +	info->ops->msi_prepare =3D hv_msi_prepare;
> +
> +	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
> +
> +	if (IS_ENABLED(CONFIG_X86))
> +		chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
> +
> +	return true;
> +}
> +
> +#define HV_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
> +				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
> +				    MSI_FLAG_PCI_MSI_MASK_PARENT)
> +#define HV_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI	| \
> +				     MSI_FLAG_PCI_MSIX			| \
> +				     MSI_FLAG_PCI_MSIX_ALLOC_DYN	| \
> +				     MSI_GENERIC_FLAGS_MASK)
> +
> +static const struct msi_parent_ops hv_pcie_msi_parent_ops =3D {
> +	.required_flags		=3D HV_PCIE_MSI_FLAGS_REQUIRED,
> +	.supported_flags	=3D HV_PCIE_MSI_FLAGS_SUPPORTED,
> +	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
> +	.chip_flags		=3D HV_MSI_CHIP_FLAGS,
> +	.prefix			=3D "HV-",
> +	.init_dev_msi_info	=3D hv_pcie_init_dev_msi_info,
> +};
> +
>  /* HW Interrupt Chip Descriptor */
>  static struct irq_chip hv_msi_irq_chip =3D {
>  	.name			=3D "Hyper-V PCIe MSI",
>  	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
>  	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
> -#ifdef CONFIG_X86
>  	.irq_ack		=3D irq_chip_ack_parent,
> -	.flags			=3D IRQCHIP_MOVE_DEFERRED,
> -#elif defined(CONFIG_ARM64)
>  	.irq_eoi		=3D irq_chip_eoi_parent,
> -#endif
>  	.irq_mask		=3D hv_irq_mask,
>  	.irq_unmask		=3D hv_irq_unmask,
>  };
>=20
> -static struct msi_domain_ops hv_msi_ops =3D {
> -	.msi_prepare	=3D hv_msi_prepare,
> -	.msi_free	=3D hv_msi_free,
> -	.prepare_desc	=3D pci_msix_prepare_desc,
> +static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq,=
 unsigned int nr_irqs,
> +			       void *arg)
> +{
> +	/*
> +	 * TODO: Allocating and populating struct tran_int_desc in hv_compose_m=
si_msg()
> +	 * should be moved here.
> +	 */
> +	int ret;
> +
> +	ret =3D irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (int i =3D 0; i < nr_irqs; i++) {
> +		irq_domain_set_hwirq_and_chip(d, virq + i, 0, &hv_msi_irq_chip, NULL);
> +		if (IS_ENABLED(CONFIG_X86))
> +			__irq_set_handler(virq + i, handle_edge_irq, 0, "edge");
> +	}
> +
> +	return 0;
> +}
> +
> +static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq,=
 unsigned int nr_irqs)
> +{
> +	struct msi_domain_info *info =3D d->host_data;
> +
> +	for (int i =3D 0; i < nr_irqs; i++)
> +		hv_msi_free(d, info, virq + i);
> +
> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops hv_pcie_domain_ops =3D {
> +	.alloc	=3D hv_pcie_domain_alloc,
> +	.free	=3D hv_pcie_domain_free,
>  };
>=20
>  /**
> @@ -2137,17 +2195,14 @@ static struct msi_domain_ops hv_msi_ops =3D {
>   */
>  static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  {
> -	hbus->msi_info.chip =3D &hv_msi_irq_chip;
> -	hbus->msi_info.ops =3D &hv_msi_ops;
> -	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> -		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> -		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
> -	hbus->msi_info.handler =3D FLOW_HANDLER;
> -	hbus->msi_info.handler_name =3D FLOW_NAME;
> -	hbus->msi_info.data =3D hbus;
> -	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
> -						     &hbus->msi_info,
> -						     hv_pci_get_root_domain());
> +	struct irq_domain_info info =3D {
> +		.fwnode		=3D hbus->fwnode,
> +		.ops		=3D &hv_pcie_domain_ops,
> +		.host_data	=3D hbus,
> +		.parent		=3D hv_pci_get_root_domain(),
> +	};
> +
> +	hbus->irq_domain =3D msi_create_parent_irq_domain(&info, &hv_pcie_msi_p=
arent_ops);
>  	if (!hbus->irq_domain) {
>  		dev_err(&hbus->hdev->device,
>  			"Failed to build an MSI IRQ domain\n");
> --
> 2.39.5


