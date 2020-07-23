Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC19122A47B
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jul 2020 03:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgGWBYG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 21:24:06 -0400
Received: from mail-eopbgr770092.outbound.protection.outlook.com ([40.107.77.92]:28886
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbgGWBYG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 21:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkI39Y9rMOoTc4k0evtxaSVyCQ5j6FcpyYFDz005a4lpb5YTd2gNWQZRsG475Q9EF38pmoF3fgHQcTylj9tuEMLKA/t7hMnpFN2ze3n83YzSQUz9kzuqALNPiThQQl0+UUfAi30NL72nRLY96lJ0gVY1mUkmbWkMG04Tlo4suXplDQyGS2IdGflHszJRmzqTqQyZlYOjpcuLZO+qIyQv9nQL8jXYwVvWcnsNeO8u433veEGQ7YGJqzCC9EqXPF2bDTVRSGJPUAVZfK1FePPaFdn3UCNNLBfo38YshttJir15gn382bzsocIjFrKqNwdsZ1Y6eYEyQ6ATJmOQlREcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCZWIKYYjwdppQt3cmVYdi3Clb0gskjXXYELRb+wNTk=;
 b=JiUFUP9bjvbvKX/Mdjw5hR5CntJVFzm0YJYL1qWWgR2boVW6Qw+LjUtCk/6CsHiCTO3uIeJTAEjuo72dLrUMMczQqQo2tAJvFS5L7818RWDUEH7kPDznaVF3S/PfwV0k92rJhC1PdwiLMngUKFhrxOaMEjT/fQUmVvMBA3XI4/UYfo3uAnJ8zg77XpKDwTve8ldEDm76CHVZ0yr2quLqllVF381Z08QsEh0kM8K+mi2DMV5P2OXfCVX5uAHY+S774McKjZEhq/LXid+gBwit4lypdCUfF7a+LLj8ki8bYlFx3ozL+FooeIWoMOL+9U8z9UMozHlsbXT3ZDubx+obgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCZWIKYYjwdppQt3cmVYdi3Clb0gskjXXYELRb+wNTk=;
 b=Sq+TactDdRMMnClHV1sN2YVZfYjq6qkE8fhDWjMakBAnRT7F8ajnjjIIXHfyPO8cyFLRxWgRQ0c10j4eYxWiofvWjHSlvt2nsexDCyfxmExRTkahODV4QKiJtgdmhSGSGraJgCHwWbeNwd931EpNWDYVLZJlN6SPPT92WNgERl8=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1130.namprd21.prod.outlook.com (2603:10b6:302:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.7; Thu, 23 Jul
 2020 01:24:03 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3239.005; Thu, 23 Jul 2020
 01:24:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andres Beltran <lkmlabelt@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: RE: [PATCH v6 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v6 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWYHjvi7DvoCSc8UCZpYMHFbSVBKkUXp1Q
Date:   Thu, 23 Jul 2020 01:24:03 +0000
Message-ID: <MW2PR2101MB1052AD4F70F592E57AA20DEAD7760@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200722223904.2801-1-lkmlabelt@gmail.com>
 <20200722223904.2801-2-lkmlabelt@gmail.com>
In-Reply-To: <20200722223904.2801-2-lkmlabelt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-23T01:24:01Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=169050f0-ac4b-493f-817e-b17af0ec7014;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92e8ade3-e8ba-48ac-b09d-08d82ea7160e
x-ms-traffictypediagnostic: MW2PR2101MB1130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB113011CD89AB566185B39D15D7760@MW2PR2101MB1130.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIvYs3ighr+V03Zq9FbURDP0CaQuzEh5jcNptrk++ahs8WrgcvUhSNW63Fc1dwokfj8mHcpVIR9XycQgQ1y2rarD280GB2OfAtzHqzqPWUY9hImO02BgqPCECMlD3yy8VMebj30ryOsRz7H41oK/YtcP4cMJg+JMvYoQP9La8xnLxCQgzBjbGy2i4OciGEgrshWel/5oXbAvAwE1S/AxUGBzFbA2f4wbte4J1Tb+QtHKRYm74JxapKFbfmBrP8Dftd1ZRch4GhS2djJ17xBpzAg0G2P1s0ajP8doNifwrCh56C1FWSQI7ZfAL7pQIW5v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(7696005)(52536014)(82960400001)(82950400001)(2906002)(478600001)(54906003)(316002)(110136005)(83380400001)(5660300002)(6506007)(4326008)(186003)(26005)(66476007)(64756008)(71200400001)(10290500003)(8676002)(8936002)(33656002)(8990500004)(55016002)(9686003)(66556008)(66446008)(76116006)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZONxxxYF/MRpJAuOZquHjzxm+56hDmbnniVDikvUmbsN0Y+jQEUK+2b5yxFYZAHRAoCvVjio1Me4/FqVWsPTJVWh8I+DEmk+Zxff60O2m+piON/1rsB7e3FIdEVpuzkmPePOY3FHqoVbFtgf/r1updjDd5HsVx/59OBpm2VYQsrADoXtAqqKPc0nZlzqiH6w4holSCOFnp5Q1HwmI/Sim0PEBVOMV5cWatuRXgww0W5KI0mzCsajVIZrS68JbZG2MuiTDjbYYYRGecreEtF1+Op9fQZ1EFuzkpH67zwJPCggF15rw/NCxU3J7FyrTGmzkku2gLQ91gPPvtFIAHXT6BzbkzS2WZi9xqUADubR7MXiGqSo/ef5s+CWk9CSOUsl5ZATq3qVaLXFfyqtcFn4WWVejTBQSDHcH2e6F6dncIXsVwLgZzpAY+Lm/MIRKVsmZugfP14dFEnI7RKc5Tu4qH2CUvKojjPdj0DV8oTnPQWeZ7yS1q88IhkwcogOjWhqLRe6gyJqfQ+S2PjDPBofMvXkgK47qCkeEAatVWWMyE2BuMJt+deGcXSwZpMLgD+hy6TtL+ID8JPZXUzStte7Jv7V/pnG37aiu/YYWZDWwysNmQA5z/s+QqpBJO72w6gp8GduiQn2rHFiOtzmMVap5A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8ade3-e8ba-48ac-b09d-08d82ea7160e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 01:24:03.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRyMAfpkb8eLQ9esG8jmg7KYT+1DsTRLLHZnAo++YVzFHcrQGCH2oxpzEn9QKj/L0hLgIhn189ZCK2wDRHB5uyRDLIGEPgoFARXo/isWgic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1130
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com> Sent: Wednesday, July 22, 2020 3=
:39 PM
>=20
> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
>=20
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> ---
> Changes in v6:
> 	- Offset request IDs by 1 keeping the original initialization
> 	  code.
> Changes in v5:
>         - Add support for unsolicited messages sent by the host with a
>           request ID of 0.
> Changes in v4:
>         - Use channel->rqstor_size to check if rqstor has been
>           initialized.
> Changes in v3:
>         - Check that requestor has been initialized in
>           vmbus_next_request_id() and vmbus_request_addr().
> Changes in v2:
>         - Get rid of "rqstor" variable in __vmbus_open().
>=20
>  drivers/hv/channel.c   | 170 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |  21 +++++
>  2 files changed, 191 insertions(+)

Tested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
