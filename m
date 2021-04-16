Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09DB362399
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhDPPN7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 11:13:59 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:3105
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244938AbhDPPN1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 11:13:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEWYKeNBxtJLa9CJaXRNL4t+TTk3ePH7t/TjWROOmqFXHb0gJg0y5sNXwfaeHNYOWEUb6I4yEd9ia049cYjlk1T2/EBkAmVOC43VW8iaQHmbWQdXIWmz5ANvTvP/e2mI1RSwKo7uMa5aXGw2yJCQ3MtPwLeikyEq50yUOU/XBEQzQfn8mddAD9twWvSCTU43LpuduAlL0TO68ggfkWRSgKPb9G50ltzWBFVTGJgGSDhOy/egBU0FgazmTuVuI81brkR9/rw/WTniUFbsUoPd8nCb+Gqamov7/gs6+H/6+nmRaiAgQ3+7Yeknnd9s2XE9kYSw71eiWi6arpMw+Cko4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM/Tfesu5FpUgzXplTedpOdB0L8K2zwxZUQQpuS86SI=;
 b=dIS7RvgQ9sDMDjTm7lCRaSDGzgkJn6uLO28sa9U7C3vQnOJfaThlGU96QqnST0ko74wng24RcNU5zguMR/eBEg3+BRhOLl+QXG4xT8QSbe9UjSlvuqYGD8Xg/+N7mI8PoD1ajjDkFF/eLKFfi/rHnscI9nwppaDDAWrdu1YlE/UimtSbUl5dSknkU7hvfd4QiNzoEjIXUR++UUqP4OvX1iwLacKVw5LfPBc1H4OFxln6KXU0KyvKtMECBn1TgV19w+Cqhcw4C9DJmQ6Y/SuUk6WYeWamKDlx/pTJTur92o8m/yO6tsHfHMiOJCAwed/CBnENQ2ZWaygEmr+XSB7THw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM/Tfesu5FpUgzXplTedpOdB0L8K2zwxZUQQpuS86SI=;
 b=eVWd7v9F3rgaPwWIpJhPGnJ3Cgl+nS0UJpFg3G/pxAbfZGtGzcLqBw92tyCydkWEykKR5n/e/v1N2t6Kfoe8mPNReJGosJOv/YRnOw13RcwRhOy0YcQHdu2gORi1CxL9nhhlUljTCakULiFTXAzUdKDRTFmEGdmZSbX0m14RyJg=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1986.namprd21.prod.outlook.com (2603:10b6:303:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1; Fri, 16 Apr
 2021 15:11:58 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4065.010; Fri, 16 Apr 2021
 15:11:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] Drivers: hv: vmbus: Check for pending channel
 interrupts before taking a CPU offline
Thread-Topic: [PATCH v3 3/3] Drivers: hv: vmbus: Check for pending channel
 interrupts before taking a CPU offline
Thread-Index: AQHXMs27vKwLrm+ylEitpqEN1ynUj6q3P3jA
Date:   Fri, 16 Apr 2021 15:11:58 +0000
Message-ID: <MWHPR21MB1593E004256AC14F39368D2ED74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210416143449.16185-1-parri.andrea@gmail.com>
 <20210416143449.16185-4-parri.andrea@gmail.com>
In-Reply-To: <20210416143449.16185-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cf0aabe4-5cc5-4d0d-a713-5c65470cf90a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-16T15:09:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b75d851-cdf2-4178-0056-08d900e9fada
x-ms-traffictypediagnostic: MW4PR21MB1986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19866A49FADBC6E6759C1C34D74C9@MW4PR21MB1986.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4fWdiobZJWXN6VGBkC59hFRhWRmWkFZQnWdPkcIPZpIA/5HOBYL8ALis1CSKUhBGT65nvMGGn8kj6fWw5bpWKoMk21za03gT8eXWNq2NN5MKzL724lz+yjYtJBbY720WoA1chlQ0NycY9qUVg0u4rKvjfG1ifFgUgicDrP2aATMbuPD3EkjltF08eerksWt870WUPQ4waP0TryL+cTMYSt3uVYZS8hm5fKGg07/5P3jEv6q9Genvo4445l3UOBKkFTxnngUgNJrT+wGqvbvRT1FqJ+z7mUcBK9Ma4e9wJxArodkINIPyZge1ATKsclv6BWKfP+xKtDExv6deaFGLU6FgMtP51YXymCJTX9cda8pTlVkuTfv5QWqz3CTsJX4fqWGCsLp9b12w3t/pjPCCVffrVn67AZK1rBrPaRDBwxrwuqiquS4zZH4+c5b5igTyPj8MhHsZciwhh9GGJqaVYH0oe3Cx2e4rPsMs1kr9IxDr5z1lxXeR97iP20nBRbiCwxIsGKzEHEWwoQDJsZxw/fNQ87T9OytMAtefcKrROnsl9gxApzgF7v1mqtpEvNjhJWmFVZRt5BS/+t0/V/oOWqSwlrzHaND7h+MvfYhzCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(76116006)(71200400001)(9686003)(10290500003)(26005)(7696005)(186003)(64756008)(8936002)(66476007)(66946007)(86362001)(122000001)(33656002)(5660300002)(52536014)(66446008)(66556008)(38100700002)(2906002)(82960400001)(316002)(83380400001)(4326008)(55016002)(478600001)(82950400001)(110136005)(8676002)(8990500004)(54906003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3yI0z/m6gAfls5FnQDi1Sa/RgWSO5j8mo+8KrkzlhfvIX8dOEp+30qO73u61?=
 =?us-ascii?Q?nckjyHLQ4FM7dugCFdAQpTj5HHBvmWsmNCkWZEKp4To1G3giqTedd6ggHAgf?=
 =?us-ascii?Q?RqfsyUBGMaUQh3mb6EdmzG2R9fl+KKFwral2x6peFC325pnMiAP2N5Ej80UM?=
 =?us-ascii?Q?eSG+iNSAHOEIUzgLcPbC9Ix6urMfBe/iPhOW2DXC4AyJei4fl5ZfTBW5/ECN?=
 =?us-ascii?Q?gsmri4ueoKlQI+ZL8HGPW8LgrYkBzlSyP9mtbALLNaxBxTHtuGa/f0fkgS+6?=
 =?us-ascii?Q?8i6bPuR+nXZafXf3z5SNcgh0QxhUlbnbIBd2FPr4dEL/n+6Dpk9YYILT45Lg?=
 =?us-ascii?Q?7dH3V/7nSQUvrgZX+nDV2tTm5+GzPGqbUHiGhMyaxlN4BZ1MdAzJY+Qf8qTt?=
 =?us-ascii?Q?izJbQtc9bD2sfWe2psRaBt80sYznRbWGo4TPDma6MyeIjZAz/euqfdh9yZei?=
 =?us-ascii?Q?hzVPbhP2hPpeqwJTaZ4+y+DaRQAvKjt/2i6FmZyi5lPjtPjuXKufTW/JP+bO?=
 =?us-ascii?Q?+yjvej63yveZWtBt/BaIsw5TJwKUwa9bS6uzdADDhQiqab4Sy5AmgLHRWqr2?=
 =?us-ascii?Q?bYO51x3UUYxsWlDEOmTLs9Hm0LQ9spJF5NnN6pyaKtrPsuEHlOqQRBIKK4JL?=
 =?us-ascii?Q?FrEYEp9m+P95mbD4kUj1/V+JJiPdXIBqAVJ7Z8F9gzOKFxBQIixr752+oZhz?=
 =?us-ascii?Q?QyXApOD03j6d0zzQXGCmPey0iKekthpz0LxwOKalIunSUE3Jd0OPY9yuUc7W?=
 =?us-ascii?Q?EZFdxPqHhhAnIhXqtmUoXgeUo9nrdHgUagvTaxhl0Fa9tcGrMrSGn9zNgYfa?=
 =?us-ascii?Q?4g7nNrrmZ1nYGX5ktVpPzLHoWgSnMGdai8cveEJ9mM5/u3BGHHCloI5so4pZ?=
 =?us-ascii?Q?vittqnzIU28C0rzHRlFfsBVJniNy6n6BBC3mY/ArpOtt66a2+Sdx1fv5WXZz?=
 =?us-ascii?Q?KUMQUdpLDj3CCRgUEjcH2L+ioZUMzRmQ1/xsqrkuR4H1dZR5/8edcDUB94KK?=
 =?us-ascii?Q?VOE0bqerY7nQ7YIT6nm0eHrTM0Va9L8oU081wNNE7pRHQ3OVmcJ7r83Bis+4?=
 =?us-ascii?Q?EkwemoKPIxSaj2yHpne6gUjww8hP+Igj7qVJVty984RMm8m2zyYBQVgzZLtT?=
 =?us-ascii?Q?yEbkLVygkvFKLUnDFmvWwBge8fQhfXJLa3kqe46NSkhPD0UC3jp68/SXS8rQ?=
 =?us-ascii?Q?3x80e95rpsGYrW1gHaaT/HpiYQvuf+cMMW9AmC6EzhEJVmgV2IXtNnRW9LH/?=
 =?us-ascii?Q?sJ6kuXd/qyQ3Vb4o0dbLY9dJi2rifNZXsSxzrEQb6ozNWpzDxV7WFWHx+9KP?=
 =?us-ascii?Q?NYFUn7aACFo5JFnZc/r6dzQq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b75d851-cdf2-4178-0056-08d900e9fada
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 15:11:58.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRVr7akqMfG2KH5dDYnnAUKrC3tRBPn6E1Dl6k+pcT+8+vwHHXvF+3wVZohw0rCA/Q5jb2gedAp/ctaM9TZQluLD5c7QeZNgnga+PB02QPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1986
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, April=
 16, 2021 7:35 AM
>=20
> Check that enough time has passed such that the modify channel message
> has been processed before taking a CPU offline.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/hv.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 3e6ff83adff42..e0c522d143a37 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -15,6 +15,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/random.h>
>  #include <linux/clockchips.h>
> +#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
> @@ -292,12 +293,50 @@ void hv_synic_disable_regs(unsigned int cpu)
>  		disable_percpu_irq(vmbus_irq);
>  }
>=20
> +#define HV_MAX_TRIES 3
> +/*
> + * Scan the event flags page of 'this' CPU looking for any bit that is s=
et.  If we find one
> + * bit set, then wait for a few milliseconds.  Repeat these steps for a =
maximum of 3 times.
> + * Return 'true', if there is still any set bit after this operation; 'f=
alse', otherwise.
> + *
> + * If a bit is set, that means there is a pending channel interrupt.  Th=
e expectation is
> + * that the normal interrupt handling mechanism will find and process th=
e channel interrupt
> + * "very soon", and in the process clear the bit.
> + */
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *event =3D
> +		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE=
_SINT;
> +	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D VERSION_WIN8 */
> +	bool pending;
> +	u32 relid;
> +	int tries =3D 0;
> +
> +retry:
> +	pending =3D false;
> +	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> +		/* Special case - VMBus channel protocol messages */
> +		if (relid =3D=3D 0)
> +			continue;
> +		pending =3D true;
> +		break;
> +	}
> +	if (pending && tries++ < HV_MAX_TRIES) {
> +		usleep_range(10000, 20000);
> +		goto retry;
> +	}
> +	return pending;
> +}
>=20
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
>  	bool channel_found =3D false;
>=20
> +	if (vmbus_connection.conn_state !=3D CONNECTED)
> +		goto always_cleanup;
> +
>  	/*
>  	 * Hyper-V does not provide a way to change the connect CPU once
>  	 * it is set; we must prevent the connect CPU from going offline
> @@ -305,8 +344,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  	 * path where the vmbus is already disconnected, the CPU must be
>  	 * allowed to shut down.
>  	 */
> -	if (cpu =3D=3D VMBUS_CONNECT_CPU &&
> -	    vmbus_connection.conn_state =3D=3D CONNECTED)
> +	if (cpu =3D=3D VMBUS_CONNECT_CPU)
>  		return -EBUSY;
>=20
>  	/*
> @@ -333,9 +371,21 @@ int hv_synic_cleanup(unsigned int cpu)
>  	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
> -	if (channel_found && vmbus_connection.conn_state =3D=3D CONNECTED)
> +	if (channel_found)
> +		return -EBUSY;
> +
> +	/*
> +	 * channel_found =3D=3D false means that any channels that were previou=
sly
> +	 * assigned to the CPU have been reassigned elsewhere with a call of
> +	 * vmbus_send_modifychannel().  Scan the event flags page looking for
> +	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
> +	 * to process such bits.  If bits are still set after this operation
> +	 * and VMBus is connected, fail the CPU offlining operation.
> +	 */
> +	if (vmbus_proto_version >=3D VERSION_WIN10_V4_1 && hv_synic_event_pendi=
ng())
>  		return -EBUSY;
>=20
> +always_cleanup:
>  	hv_stimer_legacy_cleanup(cpu);
>=20
>  	hv_synic_disable_regs(cpu);
> --
> 2.25.1

