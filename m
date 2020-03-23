Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D975718FB47
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 18:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCWRUP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 13:20:15 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:31073
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbgCWRUO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 13:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRw0EEaxLWOe24U3RW3Eyp/hRKioZ2X7zBTZrQgUcBGC2yIwAd+P+yVmoNtEo3ekRJoEaaO0dMUYkousxZHg6cCF7trpbxxzHCuv76u56CctMp6FIQIyDw7uGBGzTBl9SFWEmhKYIObmdXIBLALPqqg5NyEqR3+YHZEzOEjt1GMbRbJf8qXJ8d6MF+OA7IwxhaqCXP104OVOM5ty/Zk/E2zI5W+rZUcwuTo89MJmhefTSg1KzzCjbRy2aVwEE3/ALtV9tqmmtTyr3pCU3CGy7BwMtNPN9t0fmuOiRHeTT2wYozKhWm41hbD1idrisw8WWPp3DKI3nOtieq7wmhhdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEplDzGh4T7u0JH16MNhdqmyUuIclrkKCy0E33UACGE=;
 b=FnH3/GNurx/989W0+EqmVm1o73Ow6E5p3YQKqzZ/P25bNBJEZemhuXcX0QenXRZUhLJI6N/pOB1VQY1Ot22fqPh0qCSqd0MQYULYU2YJTPf1g2VtDeEkW1Oe45tl3KX+tgeLUnqzA7g4icFEZlv4ElogxEiteCRyKyvKKTE6Cinq/lDqMzNY7b2KhEooSfrRZ7b8c5J3kRdIfahIqFDhQiLUKaLlasHzoXOSA1y7WbKmBiXwsluUKvC2Cd2SjwTT3UM7wyTLXaV6DvJo1ErglkGvD+miVLH66iqeb6Ad6zaBd52wtZqXp8iP5x1JberGxIjlTHHSiMaq1Ie7LRJ1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEplDzGh4T7u0JH16MNhdqmyUuIclrkKCy0E33UACGE=;
 b=fBNm+ZFbCVmVmIwBarf5mVccBnYtp2kA6buzsvbO3J7Y+q7nAvrIjjX//X/pvnP0v8aWJ2zQ6n8FLwiZiqWNzNPwNqxnGKVJxJL3XzgMErfq5EN5xiip08bSJfNCvtPOTecBMhrg3yPRE99xsvbQh7rojIEqqXEJhbs++bxp8GI=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.3; Mon, 23 Mar
 2020 17:20:11 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.000; Mon, 23 Mar 2020
 17:20:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V2 5/6] x86/Hyper-V: Report crash register data when
 sysctl_record_panic_msg is not set
Thread-Topic: [PATCH V2 5/6] x86/Hyper-V: Report crash register data when
 sysctl_record_panic_msg is not set
Thread-Index: AQHWARRUrrwMia1OG0mfkGulskmHi6hWa8Mw
Date:   Mon, 23 Mar 2020 17:20:11 +0000
Message-ID: <MW2PR2101MB105226EC2D8216C68069BA62D7F00@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
 <20200323130924.2968-6-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200323130924.2968-6-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-23T17:20:09.5277337Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37656e74-dec3-4610-a186-1ed9d1ab9a36;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 553935cb-f37d-4674-2d50-08d7cf4e71b8
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1082693A4670D48B25DFB467D7F00@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(66446008)(54906003)(5660300002)(71200400001)(10290500003)(110136005)(186003)(26005)(2906002)(8990500004)(8936002)(52536014)(316002)(4326008)(478600001)(81166006)(81156014)(66946007)(76116006)(33656002)(6506007)(66556008)(6636002)(66476007)(8676002)(64756008)(7696005)(9686003)(55016002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YlBmqkpel9JHvs/WyOf4AQ5nbAftD5liasPM3BmxzMEhTrTO3cRosHJAbvUIIbV8RHk46hgOhil5V/4wJpHCpr5PBk0mxOAbbClQ9zdGBXrtnxisZsa8ZDHqfhtU7oNTRBhS9Uz13V/Kz4t8pH1wIq4EY2FV7kcS3om5Lo/TzaUxMV4dDjBnXYvPEUsFJHy71Fik+m/Lmn9G0c17KfrBHVA9R5XO5B2GVbrUgBEgS8hAaDmzGiDdlG7bHMmwg55Kad+CxoKEvgo8gpARw9VI9CJER0k2YIgRxfmMsksJcbXRubgYt63yn/n3WbVqdW33Q2yJX9osxpD5/W2K0aunUwPtCj9x0K4KLkRMn0U2EvkW8897II7U1NWgrMVrFy3qR5M6YtDOBwxYoUmL+y86le4GwfNQJd8KMHK/zUUd0xpWSi7ir7vud9zuVN9Lc07+
x-ms-exchange-antispam-messagedata: JGHvemFtt2X5QMIxw72nabDHDxDRF4+ERxRppQt073XVMOqxUZ3ims5GAwcz1651BOSVgbQ8pkzUYjpkvtLQjY9gPRxBMDUFjOL+JuFdxTMaST0fPhbG0ii6mYJVuunZVLesjYzkvNMHNGjVn5NwIw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553935cb-f37d-4674-2d50-08d7cf4e71b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 17:20:11.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r80ay12O4gyzFvRsdXZ8gYeFqnyfH+/zz7KgKG+GgxmWp8xkFKhMxv+epC8FsqSmr8k2XNj9VXy7JWQUqlw/YxNdyf8b88yXArJ9lCDPYdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, March 23, 2020 6:=
09 AM
>=20
> When sysctl_record_panic_msg is not set, kmsg will
> not be reported to Hyper-V. Crash register data should
> be reported via hyperv_report_panic() in such case.

Tweaking the wording:

When sysctl_record_panic_msg is not set, the panic will
not be reported to Hyper-V via hyperv_report_panic_msg().
So the crash should be reported via hyperv_report_panic().

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d73fa8aa00a3..00447175c040 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -48,6 +48,18 @@ static int hyperv_cpuhp_online;
>=20
>  static void *hv_panic_page;
>=20
> +/*
> + * Boolean to control whether to report panic messages over Hyper-V.
> + *
> + * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
> + */
> +static int sysctl_record_panic_msg =3D 1;
> +
> +static int hyperv_report_reg(void)
> +{
> +	return !sysctl_record_panic_msg || !hv_panic_page;
> +}
> +
>  static int hyperv_panic_event(struct notifier_block *nb, unsigned long v=
al,
>  			      void *args)
>  {
> @@ -60,7 +72,7 @@ static int hyperv_panic_event(struct notifier_block *nb=
, unsigned long
> val,
>  	 * message is available, just report kmsg to crash buffer.
>  	 */
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
> -	    && !hv_panic_page) {
> +	    && hyperv_report_reg()) {
>  		regs =3D current_pt_regs();
>  		hyperv_report_panic(regs, val);
>  	}
> @@ -77,7 +89,7 @@ static int hyperv_die_event(struct notifier_block *nb, =
unsigned long
> val,
>  	 * Crash notify only can be triggered once. If crash notify
>  	 * message is available, just report kmsg to crash buffer.
>  	 */
> -	if (!hv_panic_page)
> +	if (hyperv_report_reg())
>  		hyperv_report_panic(regs, val);
>  	return NOTIFY_DONE;
>  }
> @@ -1265,13 +1277,6 @@ static void vmbus_isr(void)
>  	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
>  }
>=20
> -/*
> - * Boolean to control whether to report panic messages over Hyper-V.
> - *
> - * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
> - */
> -static int sysctl_record_panic_msg =3D 1;
> -
>  /*
>   * Callback from kmsg_dump. Grab as much as possible from the end of the=
 kmsg
>   * buffer and call into Hyper-V to transfer the data.
> --
> 2.14.5

