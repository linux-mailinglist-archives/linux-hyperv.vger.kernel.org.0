Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639E33246FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Feb 2021 23:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhBXWkI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Feb 2021 17:40:08 -0500
Received: from mail-mw2nam12on2108.outbound.protection.outlook.com ([40.107.244.108]:54315
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232486AbhBXWkF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Feb 2021 17:40:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhzAXLZHQ4QQyK3pWhplWGEFuOfi81e/gB9TBqouW9nL1QSvrenQ9g5A5VDYwcvn3MTVQlRWlNNdR7latsyGMZ095ih/D37Uw2GYN2nkkxbvmhvA6VUTP7wkz1YI8eiThMAXjPy18DcFerY1ZPgQy3xQdh0f2FUIWKMV4wfgdomtNOJBHZ6vv3UtQ4+IRvkh1KL+IU4PtHoq+0B5uyr21tN2/eXQz/S849jequr1RJC4ywSwP87/8h09+Ad4mDfjtwxjaFr1vbtTDJ3l+YIqLJCq4wDtBydovx2zAQcnN22qhYMcx8BONszdTRBKEs0cGXAOIaVq48Thlog2T+Z7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXGaf4YdMkigMcX8q7EYE7F2ZyjsVZYo/ZnvL2xQwUQ=;
 b=esJCj1nPrEuOpbuqLWpS3G2aSlaQistIjauQzpdiyAsQFGth3jR8ANIlAo0rDe59/krljP9IEcUWSGT6xnYmiwicbM/NOYJXWQdFNJZp+6iHFgTgG0JuWqnOjY/b0+kvINzvpWicjd4NuQjN/uffbStZwwXLx2K1+HZegOq6ZM6priGbLpXKCclv5Ssdl4JxdFKl51RIQpkh9SOAx+XjsRlG6tGsjoR0Ar8oudZYCqP+xHhMV9b12oyrj3o0i98qp5mmrUYm1scUy58fRUFLB92yt8HbWo/RGEuFi6JlIM3B9wJXBiGy6y6uOP9G1VG9v6mv1+EKaZB1agpSL9yQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXGaf4YdMkigMcX8q7EYE7F2ZyjsVZYo/ZnvL2xQwUQ=;
 b=E5AAwWXuf618501gVAL4uMvLQ8rcSjf/vwk1tBtsyhnWEHfDlCSixipC0ugk4OUfhgYPkcXh6H94bBkCIz5DDBOPnekTJu69iLPfKUrJiqCX3t/BI/r2YTUfI3Oqoq+AR85j9FDEdrZMA8B2fbcgozDxIp/NpmB4Xjn4heRKATQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0988.namprd21.prod.outlook.com (2603:10b6:302:4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Wed, 24 Feb
 2021 22:39:14 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.008; Wed, 24 Feb 2021
 22:39:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Thor Simon <Thor.Simon@twosigma.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: hv_utils PTP support and hypervisor suspend/resume
Thread-Topic: hv_utils PTP support and hypervisor suspend/resume
Thread-Index: AdcK1rMGEmqDtCUwTh+l9idWk7cw2gAJXzFQ
Date:   Wed, 24 Feb 2021 22:39:14 +0000
Message-ID: <MWHPR21MB159349176C48D2D85BFABEA2D79F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <18e9886a971e42a08fdd1256ff04d560@EXMBDFT11.ad.twosigma.com>
In-Reply-To: <18e9886a971e42a08fdd1256ff04d560@EXMBDFT11.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-24T22:39:12Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3db6adde-84a2-48c6-bdea-c6fabac00e95;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: twosigma.com; dkim=none (message not signed)
 header.d=none;twosigma.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f56e4a38-c530-40c8-8aef-08d8d9150313
x-ms-traffictypediagnostic: MW2PR2101MB0988:
x-ms-exchange-minimumurldomainage: kernel.org#8755
x-microsoft-antispam-prvs: <MW2PR2101MB0988A408B87D177630E0C385D79F9@MW2PR2101MB0988.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3JWLn0OI7GCJnrGIDJ8ow/P84AY0JrPb6K7c9q9gl30WWxUcsCdjKadCVgtuu6GYOs/iVJ21BxpaJ0L4/0pnWvNNNQrwctn7HZe2+9JiRb45FXfSaFDVWTVE3F4tGLBKZWI4r+y1iZbQcS6VU9v+00KnBPPhZrFP6NbHuLxSXB56MmGMch6bV3EPceclUUYAr7EqA5pESzN3cQDPdSza8YxdGiatxZHgBzD7YwubKAxEiq5DOh0YABHwwBvQqdIG7Se1nVPo6JDRbsl5Tw2b8pR/RJL0g2rTOBG1asEfH1SAYffKpfys2E1HZjcWWwE50phA4qRJ/0L+s5uh5KAprhD9w5rGuI53nOGL5IW8KRpU2NBg/YftoCa7f5RikeUDZBCJ7j1HF74bHWhkOXcGf2NM+Kda0CYurNbNkToxPZsMrTN7Wu5j+HOAbWBsIqH/rCIpXA2l0PnGGjfJ2T3wsmP0eiA1URw5Vak1vEvzGrv9Gg2AhihgKV81E37cnQdGmAg1iHk440E6dYzm6duTtb0NgR/MnKLmGn0tT5TMVquQbPFDEQjF7UkLueqE+bXeZL/NPud+qYJW5951vfUhWmd18fb8sZk5pABXrJp6rQM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(6506007)(64756008)(2906002)(86362001)(82950400001)(55016002)(7696005)(110136005)(8990500004)(186003)(8936002)(15650500001)(66446008)(83380400001)(9686003)(76116006)(10290500003)(66476007)(26005)(316002)(71200400001)(33656002)(52536014)(82960400001)(5660300002)(8676002)(966005)(66946007)(478600001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?d8eEJZw3k7GoCZfAzYfrP40y4kS4LTOPYdiNmaUTWBtdWqn0z+hVBtt0ri?=
 =?iso-8859-1?Q?J5A9CM7Asdijylk6AM2QlCGT3PxxouB7GpNtxFLe1kH8beGe/XtvxecOnd?=
 =?iso-8859-1?Q?FxO+9zCvIa4ajle9PcjaJVK1cPP7W1+CDP5baYjZ/vh5PEXi2oy0pcxGcA?=
 =?iso-8859-1?Q?6qvrbeZCzOYPiADgFXt6IqIP1+f1FpCFcXdCjfZR8bke/eqg5OipAzGaBX?=
 =?iso-8859-1?Q?EAQPeLEnVCZvZHoRrAQRB+4wskKEz1Xc32+xTlTUFDdG1zbT1iEmKhIb1t?=
 =?iso-8859-1?Q?GAGUQ7ROU9VLk4HTYJYUlGI9lbR3anDgmC0SWfUCsHmuUzjEfC+G9p5XPH?=
 =?iso-8859-1?Q?cuJ5Y+d8LJeqPmEVkB2YH5DLrVn73UrgaZMrb+IGYZWv3BURy1YGZXODeE?=
 =?iso-8859-1?Q?B0XigK2pkZkZ/cjKcFmv4JwSMr+TFTAxtfOiTB+Vs8YgSGFRkK7ZBoyZmI?=
 =?iso-8859-1?Q?EwsO5g+2LOe5NQrlua45wn8LbQV0GEflyZ9YrOnus6WmPdMHxcKjHdzdrU?=
 =?iso-8859-1?Q?h6V0ckNybJDtVrM/Br3u6h6SfqHvtOHSA8BkI/W70EUUBTXHIEJ5hv15Ru?=
 =?iso-8859-1?Q?3ERmtkEnw4QhWWDc8hhTCw5cuUVjonf3uR00mDpjLiGHiN57HYDnnJi+Fk?=
 =?iso-8859-1?Q?fOwOU3McpgEEq5qh1Y2KSHoqIkIu6wuuZKw8A2EI5FJQrkUpRDuvU5rLNW?=
 =?iso-8859-1?Q?3baI2hqBpfU9cvHZTaP09LpMhgBlxN1U+ywWSMf6RwTbLnf2ZyIgMIspgO?=
 =?iso-8859-1?Q?MI+eA9BcMmyKO8dU6Vl2TFdhECOBeLcb16Pv+p+27ZxmVPUvJQwlcosYu2?=
 =?iso-8859-1?Q?78GKCvdhCM66acCKLVHoBIupEMBmRuTUH+owS8n4iF+slsWYOAHWNbTF1+?=
 =?iso-8859-1?Q?Y2MilWaKiCNKmNknzcpyysmW1RF5gsjWv8Bou3cUgblTCrhOrQnmGEH4Sf?=
 =?iso-8859-1?Q?ndJ+5/Lqnk6Bicco68WejN5eq7Jb7auN5FGd/mhCLiYLql+3m2sjeq4jbE?=
 =?iso-8859-1?Q?N/oMcw5mVJhIUZocHuOPgo7DM1NRnSpOZ2UWuKAM12bK4dDMxWzjgueiUK?=
 =?iso-8859-1?Q?UdwJTaXIeTB/7GMpq9OYyMsUgPGiuTfh0hpQNn6lRPBnRJfApUv0G1z/5z?=
 =?iso-8859-1?Q?740t0VudWJaiKhpSsvuj5jXngLGF8BzS64mJmxlbUSA2OsMAWygNEwOvj/?=
 =?iso-8859-1?Q?KR5rmfyxfYGa324bBlJm7aPyZJJVMUs+dh2mjauj4EMEY4h+LiZm9ixF0O?=
 =?iso-8859-1?Q?kBy0vW1XjiCcn1CiC5xXAt25kZfZHZLkMQyNTBdR6nDk29YoVua4T3puPW?=
 =?iso-8859-1?Q?6Ic107KbPdH4iuQwZ8J62TSYWalKOumCo+lm13zHL77FxANpnDBMGbMvuq?=
 =?iso-8859-1?Q?d5a0zGKBiI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56e4a38-c530-40c8-8aef-08d8d9150313
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 22:39:14.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Pd6LypRdEfV8loOiaPZPTkUyCpDKKhqwa5d1j2sjvSu4C3hCyTrLZaGsXgxIqUO8cYZOUv08B804Zcfdu8/h76JfCrfrMlVQeyIpDzJ3U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0988
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thor Simon <Thor.Simon@twosigma.com> Sent: Wednesday, February 24, 20=
21 10:00 AM
>=20
> The TimeSync support in hv_utils presently has a "fail safe" limit of 600=
 seconds.=A0 I'm sure in
> a datacenter server context, where the hypervisor's time is expected to b=
e tightly
> controlled - and continuous - this is sensible.
>=20
> Unfortunately, this causes linux VMs to lose time sync unrecoverably in t=
he not-uncommon
> case where the hypervisor's running on a laptop or desktop system that is=
 suspended (or
> hibernated) and resumed.
>=20
> Does Hyper-V provide any interface by which we could detect this has occu=
rred and
> override the test for time too far out of sync?=A0 Or, if not, would addi=
ng a module option to
> suppress the test be acceptable?

There is a known bug with 5.8 and earlier kernel versions that can cause
Linux timesync with the Hyper-V host to get hung, so that the timesync stop=
s
happening.  The problem can occur after the Hyper-V host is hibernated and
resumed, or if the guest is paused and resumed. The known problem is fixed
by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/hv/hv_util.c?id=3Db46b4a8a57c377b72a98c7930a9f6969d2d4784e

I've just reviewed the code again, and I don't think the 600 second "fail s=
afe"
limit is coming into play in the scenario you describe.   With the above pa=
tch in
place, after Hyper-V is resumed after hibernation, the first timesync packe=
t sent
by Hyper-V will set the host_ts.ref_time value to a very current time.  The
ICTIMESYNCFLAG_SYNC flag will also be set, so hv_set_host_time() is called
via work_struct adj_time_work.  hv_set_host_time() will call
hv_get_adj_host_time(), which will find that host_ts.ref_time is very close=
 to
the value from hv_read_reference_counter().  So the 600 second test won't
be triggered.

So my guess is that you experiencing the known bug that I initially describ=
ed.
But let me know if I'm misunderstanding, or if you are seeing a failure pat=
h
that I'm missing.

Michael
