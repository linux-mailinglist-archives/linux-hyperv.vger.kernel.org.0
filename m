Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D161997D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2020 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgCaNvx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Mar 2020 09:51:53 -0400
Received: from mail-bn8nam11on2129.outbound.protection.outlook.com ([40.107.236.129]:44129
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729891AbgCaNvx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Mar 2020 09:51:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwE7SJAWhISvICrk+lsc3FfZX0q5YdvEeOMN4aEwg+AO1SnOPtvOUORQVM9LrEy0JvvWHa1lvkk2KjUSRF70iSCNPccPZP1zmr/ym9uqnWrPllYbtXj7e3Uya7k2LaCUNSal/aVBEUKucqlqiR3xuiBKAePw23RV3q7Pwf/kOmQESblFYzfVmNXMMud+4IkmgJevbOEjrYYMRFAlaW1KI4ikDt+Lmul3hy1B3TCeyHNk+QomfcDE0W74rRpSazqVgZWKk/MT1RK4Tn80ORtQLvY+YEDsN5O+4EFuBILI2/5n7A6RR3OGwr971M/J3Hf8IPxtF7UMe+I15K2pBjmkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dru9s17HeKkHO1NJnCn6MPok3oczXncD2zC4QG+10MA=;
 b=HHEDXfqSUIErHM5HtfeKwIfVgbkMzv9ml28pCpDlusD4kbtGDI2KWInMzRRyFGjw0t1WoGT+HWeqTbNQgFpyWgnjh3ohrdmLklaKHgR3QWSW0qcGqDFbpFmnqeptylEwETL7Z+bun68zU82pyyzTQcrBhOQc20c9T6Y5FYxz1BOucXnWvjvTZDUMTUH0Wgzr7LHQVxGK5BxCx3nupMMmbeeBW/6iJhwO58Gdldw4tDMvsn0FzcmIAsu0xC43a5sAtnavm1onoEO/SFy73bg2nObverJgnQ/68l2u+4FFSu8CFWTeX+GBH6tLlbpvrNAhWigK7UxiCHnvoLPmAc7DhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dru9s17HeKkHO1NJnCn6MPok3oczXncD2zC4QG+10MA=;
 b=gF+9aAxLFMO8UI0Dm+ZHxK3St0EjqALWFlR34R5q0AlB68eNx5PropA5m2g+cY6/D3pHIH4iQqhRRwdeOgoqqe4ckl+qVr6w9Fuqt80JKR9SNhV8pNVTXljKilSHsYWmQZz01htcSr6Ht0wX/ub5vmEXJwOnVcwsQv457oOZgKY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0905.namprd21.prod.outlook.com (2603:10b6:302:10::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Tue, 31 Mar
 2020 13:51:48 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Tue, 31 Mar 2020
 13:51:48 +0000
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
Subject: RE: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Topic: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Index: AQHWBy9soracth5BGEahOQja8RE2hKhitilQ
Date:   Tue, 31 Mar 2020 13:51:48 +0000
Message-ID: <MW2PR2101MB1052A8FEF85F381B3EAF7D36D7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
 <20200331073832.12204-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200331073832.12204-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-31T13:51:46.4804770Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=01a21428-261e-4e0f-b3ad-8718b5ae1ef5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76dca920-ca08-47f7-a16a-08d7d57aa864
x-ms-traffictypediagnostic: MW2PR2101MB0905:|MW2PR2101MB0905:|MW2PR2101MB0905:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0905AB4AD1FCC939A7066470D7C80@MW2PR2101MB0905.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(8676002)(5660300002)(8936002)(4326008)(71200400001)(6636002)(81156014)(52536014)(81166006)(86362001)(10290500003)(498600001)(110136005)(54906003)(6506007)(66476007)(66446008)(82950400001)(186003)(66946007)(82960400001)(55016002)(26005)(66556008)(9686003)(64756008)(2906002)(33656002)(7696005)(76116006)(8990500004);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+mU0VAFMMujIrjfYCA3NuNH+tmHXYq41PEqUN0Pk7MW/b7VJNwwR0due7jOAoZDjLWJBKYLhdsRdDyRHBZCFwe22GuSplAK+SdcGvjSQcZqBUBcjwe32nvpKMT6l4UjlzL7EyoEr9QYb1oPkn4LYqCoU1dnSocZGZOdpV29Sw6E4b9oiGGEEMH6/q1Wp/DaRQk3xHXNZxyZvV3++CFjGeEwpIvhLAd1bg3ycGbMfJWwhvIdgeutgc9xiHiEkFQfDZHNn06bxwBQh8PfZGByoMcO7i6uHP6n6zZElQcXRa624ySZ0YYWdw631T8PJ7CjJBf/occ2EnRPfBHJ3HrvVB1Uy00WJ+Xvd8tj+ovHyOIfRWQULH0xX4/r3Mn+QVbTBYuQZALraMGohYVyaPVl9YOKzwJr4AeTLpW2RoGdtCa2st4AEpHF5fipedA5TtPZ
x-ms-exchange-antispam-messagedata: g8PU2ZbBqPZCtsBaa2w/f+yUTgzfc1s6hW2pXprQ+GnD+3tS4RI7neDwDzTqPR8+/3GsJ42EJCJzomvhfWZKDId0rQnwSwSd3mD5xatzdDXL7KaSlFc6yFvRrAvUTuFbBJMec2s+F+NgFrTFuEBZhg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dca920-ca08-47f7-a16a-08d7d57aa864
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 13:51:48.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leI51m3RT1ad7eIsCEpLDx74oqE9ybHhTCtYj7AO7vOBpU/ZMoeVogOi+iz+gRDKgDnbqSjNLlYmUmRtKewncfQxj0PV6YUZh9FjDsZxIrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 31, 2020 1=
2:39 AM
>=20
> When oops happens with panic_on_oops unset, the oops
> thread is killed by die() and system continues to run.
> In such case, guest should not report crash register
> data to host since system still runs. Fix it.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v3:
> 	Fix compile error
> ---
>  drivers/hv/vmbus_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 172ceae69abb..4bc02aea2098 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -31,6 +31,7 @@
>  #include <linux/kdebug.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
> +#include <linux/kernel.h>

Unfortunately, adding the #include doesn't solve the problem.  The error oc=
curs when
CONFIG_HYPERV=3Dm, because panic_on_oops is not exported.  I haven't though=
t it
through, but hopefully there's a solution where panic_on_oops can be tested=
 in
hyperv_report_panic() or some other Hyper-V specific function that's never =
in a
module, so that we don't need to export panic_on_oops.

Michael

>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  #include "hyperv_vmbus.h"
> @@ -91,7 +92,7 @@ static int hyperv_die_event(struct notifier_block *nb, =
unsigned long
> val,
>  	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
>  	 * the notification here.
>  	 */
> -	if (hyperv_report_reg())
> +	if (hyperv_report_reg() && panic_on_oops)
>  		hyperv_report_panic(regs, val);
>  	return NOTIFY_DONE;
>  }
> --
> 2.14.5

