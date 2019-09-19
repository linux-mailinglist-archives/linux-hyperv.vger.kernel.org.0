Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52228B87D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2019 00:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406842AbfISWwq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 18:52:46 -0400
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:27317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406075AbfISWwq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 18:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy6HbKI+P73OIvQim43c7D8D3tevzfbZe2jRKMGiafVg5ot17dRw49bEX9x6wSA2is/6Uc3fdO2NwnvsXGRyoGD/WZckNF/eb47r3SJqzynCOf66VuORg92RQHEYGseQj5feXByoCirn2GRWNTbX4q2dBnxGLzWhz4nk+Y8D6ymUBuBrQvdvVHlsLP8fjsN0c3cfr+KZDMYQMaJe6k5YzNElvKSVIBWio+A4uHlaBfNeg3UKSXhlQjVokUIKWfH5/VEEPHzkOd7DdkTtylbo6Cs+CZ/xNyCzppI6OQD7+GNVJ6NrWhLCSkPPKD/W7YCv7VsU06fVD2e9Ioj+IZaE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz3YEv63oaIYyNaX3Fi4sGwRJTFxrM+ChZ22Nc/wUXk=;
 b=F3YRGY8KhOOsQgP8WXPAowlNSd73GZxg2wIc2l/UmWeMij6H17F/NNSJVD7tVQSJL7p7myAXZ6AaKhfaZc/KFix+sZIDuWOr95YFrW99rJgbvv+W8Z9Tc+96Qa9OkN1yW+Jql7kA/rxw6hyWqNHBfncIz0FvM9vSEkk4Ix1mZmKT29HWxLZQyNB/XRQT8SZ/v/lMegfq8Au1+ddZY2e60xGnDbQ/w8YtLYZq9d79uTrWmJVfPH8adyltcVwQV7AmPI+Xsg3RyOaYxqGx6QYn/a5cB/HOSiGR/j9SUTaqrWpSMI57pg0B0n9GptfhoO0NcLppbEf3IFK1RrKYVixY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz3YEv63oaIYyNaX3Fi4sGwRJTFxrM+ChZ22Nc/wUXk=;
 b=ZfDNwYFTs7Lr7gnsMKAZY89YHbq6xxHJOUJJmP1KVy4S5WsoYYczmkp5v49j0P4AETbGOO20TgaQbeFrX4tHDXwE0cMp2cp6Bg3imTMXb4yYpIjQfnTh0hA0eD6BSy1LcfC3DwuSuMnugv1DekjT7VD9C10/ZbbKgPexl/fFox8=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0476.namprd21.prod.outlook.com (10.172.92.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.5; Thu, 19 Sep 2019 22:52:42 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028%9]) with mapi id 15.20.2284.008; Thu, 19 Sep 2019
 22:52:42 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] drivers: hv: vmbus: Introduce latency testing
Thread-Topic: [PATCH v5 1/2] drivers: hv: vmbus: Introduce latency testing
Thread-Index: AQHVadtzew0WJmIvLki2E308Pus5yaczoOrg
Date:   Thu, 19 Sep 2019 22:52:41 +0000
Message-ID: <DM5PR21MB01373C2DB4DE6A4B6079C2BAD7890@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <cover.1568320416.git.brandonbonaby94@gmail.com>
 <83b5fc34e8f25c882f2502931f766ef547c6c950.1568320416.git.brandonbonaby94@gmail.com>
In-Reply-To: <83b5fc34e8f25c882f2502931f766ef547c6c950.1568320416.git.brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-19T22:52:39.8991962Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=58d98171-0531-46fd-9f19-95641cc1cec8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f00e84e6-c319-4671-a100-08d73d541428
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0476;
x-ms-traffictypediagnostic: DM5PR21MB0476:|DM5PR21MB0476:|DM5PR21MB0476:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB047677352912CE9D1409E69DD7890@DM5PR21MB0476.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(6436002)(1511001)(486006)(256004)(81156014)(446003)(9686003)(11346002)(229853002)(10290500003)(6246003)(3846002)(66446008)(86362001)(4326008)(66066001)(2906002)(10090500001)(66556008)(55016002)(76176011)(5660300002)(2501003)(81166006)(33656002)(102836004)(8936002)(305945005)(6116002)(186003)(74316002)(25786009)(8676002)(64756008)(7696005)(66476007)(7736002)(22452003)(71190400001)(66946007)(476003)(8990500004)(110136005)(26005)(316002)(99286004)(54906003)(6506007)(71200400001)(52536014)(76116006)(478600001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0476;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /w2fhH55rWUSoSnVRChwVnJTTIjRrGrz0E5Q2+zHIVMciPtNgUtE4oEwayMRLBNZk9YS6hWBDkOgFYrV8m/N0EpV6Jzt4uIsfekB5LGUOnAVnAgP2vu0q7/VEwYYsh+3qKqWYXHitzO8o1VQkHskQuuLT815PPTGMP5MLpdaUCKZqTmFFSfUucNn6N8RcY6RtFaMvP+sh16y5ABmYw2/L3z4h0ysftwaZDNGoaEqsHGbox32TEkyK2lIeKdt2VrfbbpUMtAUiNpkKqXdI1mB+A3bNHhxFfzIl1U5u0Mz1+GAYvw3QirdI7aovWxq4BDGfv92O3UsxHHfpEZe223qm7HatmQApPTqhmqGZKdyhJu+7se62gnIdR5AwWAEGojJKWrDhLoP2HBkk8Pd1dY8UY1a9cwgrs9BnEBDlrIgBnU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00e84e6-c319-4671-a100-08d73d541428
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 22:52:42.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /M9UUxsPZRCGy9q1N0q3DhY6UCSLCWlVGD8yEzlvF1sEXK+oEq71volXDWBrtgKCYI0nuIDMThw845Wi2GmOFUqApp72p1cQNpQ/8VqXEyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0476
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Thursday, September =
12, 2019 7:32 PM
>=20
> +
> +static int hv_debugfs_delay_set(void *data, u64 val)
> +{
> +	int ret =3D 0;
> +
> +	if (val >=3D 0 && val <=3D 1000)
> +		*(u32 *)data =3D val;
> +	else
> +		ret =3D -EINVAL;
> +
> +	return ret;
> +}

I should probably quit picking at your code, but I'm going to
do it one more time. :-)

The above test for val >=3D0 is redundant as 'val' is declared
as 'u64'.  As an unsigned value, it will always be >=3D 0.  More
broadly, the above function could be written as follows
with no loss of clarity.  This accomplishes the same thing in
only 4 lines of code instead of 6, and the main execution path
is in the sequential execution flow, not in an 'if' statement.

{
	if (val > 1000)
		return -EINVAL;
	*(u32 *)data =3D val;
	return 0;
}

Your code is correct as written, so this is arguably more a
matter of style, but Linux generally likes to do things clearly
and compactly with no extra motion.

> +/* Delay buffer/message reads on a vmbus channel */
> +void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay=
_type)
> +{
> +	struct vmbus_channel *test_channel =3D    channel->primary_channel ?
> +						channel->primary_channel :
> +						channel;
> +	bool state =3D test_channel->fuzz_testing_state;
> +
> +	if (state) {
> +		if (delay_type =3D=3D 0)
> +			udelay(test_channel->fuzz_testing_interrupt_delay);
> +		else
> +			udelay(test_channel->fuzz_testing_message_delay);

This 'if/else' statement got me thinking.  You have an enum declared below
that lists the two options -- INTERRUPT_DELAY or MESSAGE_DELAY.  The
implication is that we might add more options in the future.  But the
above 'if/else' statement isn't really set up to easily add more options, a=
nd
the individual fields for fuzz_testing_interrupt_delay and
fuzz_testing_message_delay mean adding more branches to the 'if/else'
statement whenever a new DELAY type is added to the enum.   And the
same is true when adding the entries into debugfs.  A more general
solution might use arrays and loops, and treat the enum value as an
index into an array of delay values.  Extending to add another delay type
could be as easy as adding another entry to the enum declaration.

The current code is for the case where n=3D2 (i.e., two different delay
types), and as such probably doesn't warrant the full index/looping
treatment.  But in the future, if we add additional delay types, we'll
probably revise the code to do the index/looping approach.

So to be clear, at this point I'm not asking you to change the existing
code.  My comments are more of an observation and something to
think about in the future.

>=20
> +enum delay {
> +	INTERRUPT_DELAY =3D 0,
> +	MESSAGE_DELAY   =3D 1,
> +};
> +

Michael
