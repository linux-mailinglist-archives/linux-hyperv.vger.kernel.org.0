Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682D4315321
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Feb 2021 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhBIPq1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Feb 2021 10:46:27 -0500
Received: from mail-dm6nam12on2111.outbound.protection.outlook.com ([40.107.243.111]:29729
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232617AbhBIPqR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Feb 2021 10:46:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE6sNuRE8YNF35ubQNYS3VW2vYWqD4hpj0CUb1xXbFCBRN6ZJ7iZziItHnv8RK5tvxVsy7GyuydLJWwtUyNUriWlPzaBCam3VbkH6OTfVlVaW6xKNwrP8Jix80Ml2TPdlgGVASii9NdkuVruh3QOPwsIjDyyNBr8AAlUhWtP9Blq17F5FqWnuFbwdKC6q75vIQd4SRUrWDK3foWd98DMQ/CEFVd3d3zkYq5QNoR9M4OGpIpEANnKjHE00SHuZsV1UMQuOhl/26f3gcsMcJK+4YnYECAPNmo+Yd9vZ23Gbo8Ns/tKjq/IqIzajWEh25z9Z7Oi6Q3wUWpJIKFtwYav7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZo+Z5rCHA3uWU0UPEZl4FPoJ2diSM4k0M00XcxWlyo=;
 b=dKKTI/QFdtF6mK4mc9MJkWvApox/h5NDX8VKtlfvpAGOFiujwCr/a9wsb76dXSxoSNGV+Nqg93Wb64CXIlSr5PFo8lJ15cVdsnJDHLFTdOjRMgPCLsVeOaChBgjunGrQbXnbNLkqGUAhObPr7JIJ1Itu1HnZAbRSa+/mXKqaUZ8foBcu5bfHoM0FCHt4Dj1CsosYv2vXZP/9SguDzc7ytUCjgxM7ASZbG4mFKh3QkDuxiBCLTKpaNDagbLKD3DCkpsPdQX+RrT+nrDm78Wzu1N4c63x80g8dYpMv+pyA1vCUKO5iILWMItT4REj6PpFpiaYxXGRK8gLHduOD5nPJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZo+Z5rCHA3uWU0UPEZl4FPoJ2diSM4k0M00XcxWlyo=;
 b=d7SK1ulFmjatppcPJUfJJpvGj+oHAsSO+QcF10hXDId963qICAGVr3TZWOShRCVSQJKDPm7ZhJyWhx5XeUCAxAXSoFRWE/pWUFUpcoAk09M58t3zLmDd8VFzGg+rqt28HGDwSrBuBHbFQodw0fJRYr+9B84rwErSqsIV52spqG4=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Tue, 9 Feb 2021 15:45:23 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Tue, 9 Feb 2021
 15:45:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Checking Hyper-V hypercall status
Thread-Topic: Checking Hyper-V hypercall status
Thread-Index: Adb++n8ogyJMSMSTTsShZW27ouTAzg==
Date:   Tue, 9 Feb 2021 15:45:23 +0000
Message-ID: <MWHPR21MB159399C0A82E28CE9A9B93DBD78E9@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-09T15:45:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f50714cf-68d9-4e50-8247-055b0d6b840c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1bc25aa-afd6-4b86-6a15-08d8cd11b6d8
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-microsoft-antispam-prvs: <MW4PR21MB1956470708538390E3B38402D78E9@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 391SGq8TsKpZ8W8HtZKF7wziXsjnzjjIj+bDlQFq8NIEGMWSIiRQpbBDmppkqx/m5U6MWjBWm2/bYIRr/rkXhMK1EkjQccP2zgId+v9zOswDJYLOvvEBuIhHihdjw6EHrIXQJMQubd0X6/IJhUhKYsL+fS0UVBezVu3gSXIPJGCJ0SEXCP+/mTp8bXD4iIZwz8e10mOhvT/3GkOen+/vNhYTTshVpKUTSm9OCXSeY+PY9rCBKA3aI548prCu/uh0dNXV8aX5rj3aNFLz6v2fEXf3aS1t5ln+GIENXSgGB8hJjWiLp8plFKjmaUNyGJUzrEia2I9Uiglk7dpYRfV8C4zKiVep43wEJNcOktR4NQPPVoVvt67RFPzlFKD6XmyXtWprg+tJ1dqchqDTRdVAwHStqofmJ91C+UeMWw8Z5/SDEzNPIeXi2p9cHsytkOJ2nV4n0aUiD/mIbkroWxE2MIX7rwIuNvy5yknM2PU5WoNgAArGuChzKOV9L5ERU1VEU9IKqHjUpTU601uSPZdGlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(76116006)(2906002)(5660300002)(9686003)(55016002)(10290500003)(186003)(478600001)(86362001)(6916009)(6506007)(26005)(316002)(52536014)(71200400001)(8990500004)(82950400001)(82960400001)(7696005)(66946007)(66446008)(33656002)(66476007)(8936002)(8676002)(64756008)(66556008)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bfBeyU3+3AR8CpRaXB7H+ZiN84d6a7t1aCJxRygsXRaiq2vZB67V6/MG4vQL?=
 =?us-ascii?Q?+dv7jDDAn34ZdSjLCDr690Bnr7w72FaenEmdDC78xPdYN5+NdxtFC4Yo7Zml?=
 =?us-ascii?Q?l33X1GcBk7wRMtEU8nmVov46oUoCoTV6QYdQXkthzQaMysJpj8xJx8/keF2s?=
 =?us-ascii?Q?H3bUfCiODmO5XOYYN/M6FcaL9kdnJvfTHllyzbAg16evocvqfqpWC5RHlHLW?=
 =?us-ascii?Q?toSdzLdlDXkHwMJfZ3Zq9T+SJhwZ7sczISuaT/CqpAfGQWCeSvV0WUHRTB2C?=
 =?us-ascii?Q?beiww0bUSU65e8fhLqo8y5zuzYcsOBk6Qn4Ssre4dTz7WHiRhCjq6p2Fhihv?=
 =?us-ascii?Q?RwZEXrExBgex1sZdZ3jqKVgdG2wXCdWwyASYOrGY32nKKPdXnX1EsPDaRgrl?=
 =?us-ascii?Q?5aeUVLUFdjlBtWvL+BoTuxOCmSqISV9CLFEo8ST7kVtX/87Ymt/L643JGKva?=
 =?us-ascii?Q?WBmCOoNjNnDnC1bmy21puhcHkHjSQc+ldSkCHE5NGYFngMt2w1z5Z7YYgmYm?=
 =?us-ascii?Q?hS+TZn1+eKEXA44OvRRewBloq75JqsPiPBFzc2Jn9KWwMpBoosqFK5FfLv94?=
 =?us-ascii?Q?Ef429G/eA/EjI/cEVCq6iMmUsJMIYvqaAUJrqFfncF8P2SePPIG0nrtWtzRZ?=
 =?us-ascii?Q?SgJ99OOOSbIoEs1eAcG4fIP8b8QAcFhCNQUvY/qP8rfVLtzjLZ+ydvPdb7MQ?=
 =?us-ascii?Q?dT2gdEZwEKa3sKvAzq0T/Oezw+MLysdaNg3/LgqUZq+lOJp4iOmlJ1TSc7Bg?=
 =?us-ascii?Q?sbUzVOtaTu1+uYOaCzmq2qOyN4pQ63Y1B/XjUk8Tz39XoFwadp0NOuP9ZqX9?=
 =?us-ascii?Q?tGwR5GmegoaUfPU41nEV7IdepxVbP9QbGXufi62oa9dydPCXWKXltuVyjfhW?=
 =?us-ascii?Q?uWzZYK0XiAL+iaFi2wke/sEYkulMmRvkS/C/2IQmiujonzrDqQ/x120Z7P9S?=
 =?us-ascii?Q?Sdmd0D1FGXbBk2JSVwzFwJTokxCgO9nRKsbyX+8lv3hESuITGLV5OEgeiYsx?=
 =?us-ascii?Q?nR0x0q/vL/by6Qk498APVIax7dUmaNgVlxvsdmEZidPh/W/sSeRkSjq2Ahcc?=
 =?us-ascii?Q?ybdkj4qbCS3kBhf9lKzQ1GQqUUaR+JPrQJP+ypvez4sHzNIRLTuyA0hLEft+?=
 =?us-ascii?Q?wUD+xBmvcv4pIG9iAthM+4tBuzHPSLRtAioZ7vMVskW2QXchJGFRprTwS7oP?=
 =?us-ascii?Q?CGuUIq6dTTPzftPAiozE7yyz9riE8gp5dgoVVelGIiVHzasu3W4u0I8ww76k?=
 =?us-ascii?Q?nWlG1DX5yif2uS0eBWNGYJMPooEnco4in3Vg76/rzboCQG4J8gMlXMCw6/du?=
 =?us-ascii?Q?DSpwnCl1UOZMA8WEiU8NVGJJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bc25aa-afd6-4b86-6a15-08d8cd11b6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 15:45:23.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAapG4MZeuThVSMh3km2sNiTmT3r4RU7gZjGrnyiWYv7XPA/+9U+hYW+GQ2pMpe5XBXHq+y/x/WexJX01hmHaGHa3z4G9NCb/GliTtjamPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As noted in a previous email, we don't have a consistent
pattern for checking Hyper-V hypercall status.  Existing code and
recent new code uses a number of variants.  The variants work, but
a consistent pattern would improve the readability of the code, and
be more conformant to what the Hyper-V TLFS says about hypercall
status.  In particular, the 64 bit hypercall status contains fields that
the TLFS says should be ignored -- evidently they are not guaranteed
to be zero (though I've never seen otherwise).

I'd propose the following helper functions to go in
asm-generic/mshyperv.h.  The function names are relatively short
for readability:

static inline u64 hv_result(u64 status)
{
	return status & HV_HYPERCALL_RESULT_MASK;
}

static inline bool hv_result_success(u64 status)
{
	return hv_result(status) =3D=3D HV_STATUS_SUCCESS;
}

static inline unsigned int hv_repcomp(u64 status)
{
	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
			HV_HYPERCALL_REP_COMP_OFFSET;
}

The hv_do_hypercall() function (and its 'rep' and 'fast' variants) should
always assign the result to a u64 local variable, which is the return
type of the functions.  Then the above functions can act on that local
variable.  Here are some examples:

	u64		status;
	unsigned int	completed;

	status =3D hv_do_hypercall(<some args>);
	if (!hv_result_success(status)) {
		<handle error case>
	}

	status =3D hv_do_rep_hypercall(<some args>);
	if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
		<deposit more memory pages>
		goto retry;
	} else if (!hv_result_success(status)) {
		<handle error case>
	}
	completed =3D hv_repcomp(status);


Thoughts?

Michael
