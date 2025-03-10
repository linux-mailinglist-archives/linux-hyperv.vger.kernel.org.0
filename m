Return-Path: <linux-hyperv+bounces-4359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF7A5A557
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 21:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDE0189383B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59541E0DDF;
	Mon, 10 Mar 2025 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b4YWYDan"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2029.outbound.protection.outlook.com [40.92.18.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9321DED4B;
	Mon, 10 Mar 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639933; cv=fail; b=qlcEvYklzEwROuKpTlRAienvSdMPLyN8KbZ32fMhf+XHT5cSummqeQuKJ1CnQRsIdhemWneBlbjSkDDASI5R+9WUknQVQskGis/T9L0wV0OQhz3In99cqQrsKIUj7WE/6+PFgpf1ZQsKMnszcIXxu/affHYU1AbrJIEiLsASzp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639933; c=relaxed/simple;
	bh=DMl5mO7f2XAf8KYP9qGZ7D3TrKjotUdNwLYBCNwOhWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdtY1tUxosizshJPRi7kxSq2ocoEhseUaxbr78/WqlZI2ztDOazt5+V2rRImWt9lccxKAgt91dbrfMy3j7iX6PhBINyIiki2cWp/IKJGehg3aqdXZfYzOMCl5qh/xK3GVlojXgRlD4n86i55bXDBZM4Rb8um0RtlUNzvgj66r2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b4YWYDan; arc=fail smtp.client-ip=40.92.18.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDVmvYrJuAH1GPXBJmslKgMa9RacS3M+e0M9scnbQWeTx1VuwAv/TX/f69quYiPlq16Mngp50qYwX/l1Yvlcxob0+H41/7nlsKCw5JSOInlWgL9uNXofJIQ21ISN7paLc/odkvsNZEiw5vePTU8kXrxvirqOGL4rnZ1SRgQMvj6WEwivZ0lYRYMbKrw6IEt4ZU7Xi9zgEZ7odr6l8Cr8WBcSXNufHmUzEthssJMPLXDPW0+rgAGW2LwgXYPE2U7IbYkQD6X27ZTP/2FbWXNnqNFK4q3ujcy5dZIqT7yX1pHemOfZR8fBZa3x9jpnMsrPp628hQmgfPG9+rdmCCvP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm9YiobwDp14A6uQtNQY1OD22O2ZF9O8dW5lucHldEg=;
 b=mnk/J3yAuWSrFVSMQhUDwpjftU5MREbJvnkISo8arIAXzWyX36k6BFuzy4KXEkEwjdSahVAzxBpUqVoxo4KmpQo0bA2G/Ws1+dMLQyiIIbpH7utxDLPUDJZZb09rGHyfIbF+2BoEQ543kMbgkzy7BbC8LtBYQhw9nfNATphrLvk0CcRCMyzBBTQiojDZQvvm8whe4Vun4QAB8Q8zkuhNvU/VEzaJCW45iGV2aHxolAoM6+Scr+8er3Ipu4qQErbByo0nrMbV+JXKYxSkoj3zJsIG0vt9fulCgxCc6E5S4oUyU95OFMJMux/feTR6MfyAqf5tw/Ui9a9tE+U8A1usqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm9YiobwDp14A6uQtNQY1OD22O2ZF9O8dW5lucHldEg=;
 b=b4YWYDant0+6uJd86uyzKucBe/4AW/4cMPgKqSugD7LkEzOTuutvm6IqtcWxYjorgZOps8UL/sKa7UNON/94jVm2tAGlqNzipJ9AKE0OBiDNo/Kf1H0kUNj3UawCS1vKvv2ET9DglgWvKMzWPHtW5SVh4uXBPM7qc4q3HczVnbOuFrk2zxBIWsfxk58J11wpUtoF5kzgo7Wt5IqxGyUF32UBAJISy12pgihQ1JPm333rEwfiBwZuC76JT/K6rX+pcPuW7Hbr78klom2IA7XWjjRQH5rf4/eRvIKP7tp/MLFqQ4YteoH+oCAIcXVOBdSD0OAZuMlwCjr3Bo6qij4g3Q==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA1PR02MB9673.namprd02.prod.outlook.com (2603:10b6:806:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:52:09 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 20:52:09 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: Remove unused union and structs
Thread-Topic: [PATCH] hyperv: Remove unused union and structs
Thread-Index: AQHbkfJebyVFUgBJq0+B7AOJi27pP7NsyzHwgAAKX4CAAAE1cA==
Date: Mon, 10 Mar 2025 20:52:09 +0000
Message-ID:
 <BN7PR02MB41482371FF25FECC122C73A8D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250310192629.443162-1-thorsten.blum@linux.dev>
 <BN7PR02MB414819702EA59A53FE581943D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <ACB6A959-C2CD-44E7-A1D6-AB9263C29D4D@linux.dev>
In-Reply-To: <ACB6A959-C2CD-44E7-A1D6-AB9263C29D4D@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA1PR02MB9673:EE_
x-ms-office365-filtering-correlation-id: 07948303-f545-4d53-f73f-08dd60156cd6
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|8062599003|15080799006|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y4l7lprhGYXzoesRKT96kB4mc2YlH8Qwii50HJWN5IiZa2DMVJJfV/J3LUDl?=
 =?us-ascii?Q?aNi688kMwDhdUx3IrSb5RENkG0SXK6yIRGogNW6bR3MH1vtEIn31mSFcMpSa?=
 =?us-ascii?Q?WNXVZ47OWv7O28z63ziuCWbNB3nEDjEHGy85B6fEoW79KQEgM0lSaohrhzrx?=
 =?us-ascii?Q?nH8E7J+kCLF3cFPkcFhLkM2LevyeG093tgMK+smlCYM7UdePAeYsKd8SKw5z?=
 =?us-ascii?Q?Xf6tFLfDEsISamlp+cCAIw+lV3zYUoatvgpYFyqs170MmwIIapyCURhIVnzL?=
 =?us-ascii?Q?rVV8jlKjupWYLBX+0aM0acW415w6ALh9ZItHDllRMFcygVaZNlDqWmkjlQVv?=
 =?us-ascii?Q?HQNz7T+mG6vFe/MpzIvveb9qiyFu9Idng6WfabaQ3EFnZRORyk4MBakNU3He?=
 =?us-ascii?Q?Y4oI6+Dmi0sN74a8ndk7k/VToGxiT1dHgVPFnKCaAyXSDmTa9tP60r5+3vm1?=
 =?us-ascii?Q?hBxmR5cb3llKy3hSilnKVe1cI/IeARBI6OWomLAaHs9OpiaoyffiAAuAebq6?=
 =?us-ascii?Q?ju8/C+lyiGzt0/AyVLJbSAFW7E/GazQ27OghN/Tn7TB+Z47/8vJ06/G3C8Pt?=
 =?us-ascii?Q?HQ1fTQHDxKhwzTZgHcs9ri6C3/1urPBrqE61NC8ZK1fJKrDmUq7/maLrvj28?=
 =?us-ascii?Q?+d19G4LDU7m602zKRK00xjpyqQXNKnNkPajbsZZQRDPmI6Wag/pPg0fYgeVI?=
 =?us-ascii?Q?nj+1I6LgyzPNoJQ/UDfeXSe2jw9G8/dDIyEupc6EUiRkVOvaTJ2Ub8yGvKqc?=
 =?us-ascii?Q?NbzKNhFH638b41ebFeGUSoXhPGBMxn/oEq1kNv3+ZCQkqdCYpxnIwEndC9xB?=
 =?us-ascii?Q?PTRTMt3HwiRhnsQtP0y9gFjLH6RRbAsXYT/YSJkpWoihAHbaUu45pJ6JIUvz?=
 =?us-ascii?Q?lmm3/0mJg0RZaBhWArbOQ0q+Mq+Pob0doJsySGhReHJvfQGPUtedpMoVmhtJ?=
 =?us-ascii?Q?FDv8OcBjeHpD1hRL0GN0G/c4g2twZVzEkfuqVxJ52uFr58PqEQD6SSfMtvzw?=
 =?us-ascii?Q?l9CEHw2xxytZceTeX10mKFpbGdoQX6H/NMK5TZdvlKoRRi0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6+TWG/KCtX1jgSiwQLPxZOQFIQWAb24pC8eS4ryPnuBGaVmJeGOtEApu7CSo?=
 =?us-ascii?Q?UT2bcdkKJM7MgFayFD62LtO0KJ8eUBq7r3qTgxlsgW5adRxblhX7wjch6uTW?=
 =?us-ascii?Q?e/wkAw5x9BKYtVc+SHQfSC8naJzjeUXm0zhg2ElCmEsZrMznE7+eaS60lskV?=
 =?us-ascii?Q?vxnVbHmWOsYmAYJG7ACBew6XikZytgJjIBW4aufU+sa48R8/4Us0mYOOjC/R?=
 =?us-ascii?Q?sCZywu07bZlrGTJt8oOMLF/pB65H0SIg9XIjGGMQsjAjNnUU0Zix2N0eAc0h?=
 =?us-ascii?Q?+r+9A/8mP2jNTl6Sgbdc1pO0foFyUKoTwY2ZZyVLIzkO+Br0wdz8w9hKPTgp?=
 =?us-ascii?Q?nZ67DczejPZeec0l2oB38ODSGZl70an6PzZQeWFqQvdiwL7sv9nCpC8xS2AN?=
 =?us-ascii?Q?zrnPKn8EawkEgR0KsgA62hCZRu5R8p7wh4PSzkepWOwmstRp1HUabr1rajUz?=
 =?us-ascii?Q?9F+rhw16/xbgz2EcFbNNRtjM/LDEcHiPlvPJjfv3039yaKhtlt7RPdeiwEg/?=
 =?us-ascii?Q?o/iA35G2GUQCx4aH9YddeFSfHknmfyE2iVEY/WDbVhkP9LKmxwGjmmEtwNao?=
 =?us-ascii?Q?X87af0VmG+Z70zV5JVAEpeDcYbalPuVbfwoCV9w8tsZNziZG9kHh/N/MoItl?=
 =?us-ascii?Q?1Ow44HnS1avzFR36DYxaSZADfDsN+WvZOaKChU9+09cA6g6QQtW8MTe1l51D?=
 =?us-ascii?Q?GUmIpg9nJA+hTyS5DrKjqBNE/v79Ua6EPimQLY8DCgrIiDlSRgBV99HRt8KU?=
 =?us-ascii?Q?0PkqyQvqRCRa3Wf/bpoCIHeIVpDhooRaJ+OQd0ragQZnAi6yQTktuzb3LWiP?=
 =?us-ascii?Q?YYnuQS62Aq7MeEG9yCZhGmf5KD2PqGGvPBKmJV2tUHP+KDC60Ihz0hKSjvPL?=
 =?us-ascii?Q?5YLK4C1/ncG4P7e1zGNakc8zYAeJeWi8u9MqtsgR7ZufHWCcHhj+es9t/GcG?=
 =?us-ascii?Q?p6xYXB3O2QBiAbxote8/Z81rHZqH6aln+6Il/wSzbBVW6fxy8xZLQRJmMdkb?=
 =?us-ascii?Q?cjpLaW8Yr7T9h+1Qxh9JmFxBjboKrNNXjBzMuqKieiJ8tBXbQSIwZPldOKBS?=
 =?us-ascii?Q?Uj4ei0kXUgG1DJ6D/9JQ81a3KsBmxaBnmYuV5FzfMg7zyQQgoLo6RsXRH1JV?=
 =?us-ascii?Q?dl5VJoqaCMDdtQpjzTRwkzMZ9BDSS+LKG5FXpCI41rnW9VuVUBp2Xd5K0WCM?=
 =?us-ascii?Q?IBRuFj7oUdclpqqbNWiB1aFxUZJ/XmpQkdjJxtEnPNAzGcl8+h0+eAgT6O0?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 07948303-f545-4d53-f73f-08dd60156cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 20:52:09.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9673

From: Thorsten Blum <thorsten.blum@linux.dev> Sent: Monday, March 10, 2025 =
1:41 PM
>=20
> On 10. Mar 2025, at 21:21, Michael Kelley wrote:
> >
> > It appears to me that struct vmdata_gpa_direct and struct
> > vmadditional_data are also unused. Did you keep them for
> > some reason? Or could they also be deleted in this patch?
>=20
> I kept vmdata_gpa_direct because it is referenced in multiple comments
> of other structs, for example:
>=20
> /* The format must be the same as struct vmdata_gpa_direct */
> struct vmbus_channel_packet_page_buffer {
> 	...
> }

Ah, OK.  Thanks.  There's marginal value in keeping
struct vmdata_gpa_direct so the three comments provide a
text-only reference for keeping these three struct's in sync:

1) vmbus_channel_packet_page_buffer
2) vmbus_channel_packet_multipage_buffer
3) vmbus_packet_mpb_array

I don't know why an actual structure isn't used as the first
part of these three that must be the same. But changing that
is bigger lift because of the field references that would need to
be updated. So I'm good with leaving struct vmdata_gpa_direct,
even though it isn't directly used in C code.

Michael

>=20
> I only checked the structs used in the union and didn't check
> vmadditional_data or any others, but I'll submit a v2 and remove it.
>=20
> Thanks,
> Thorsten


