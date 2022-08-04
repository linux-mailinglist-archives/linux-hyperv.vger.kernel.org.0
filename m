Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851435896CC
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 06:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiHDEEF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 00:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHDEEE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 00:04:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3084B4A2;
        Wed,  3 Aug 2022 21:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1a5ATszyVSxsVo7W/T+27El5MQmZ/YSj9Cze1ZQ9St/P1nkIR9lrkyZZJELC0bi6TSlYZGSwOB2I3kTBBwl8opeBcVT+3SpgUmZrP+T1+KqslN5/f484yZb5kxOAMwcNBZXv11t6bjNekBx2/urM6/2Y0g2maA1xdxZoVw3uYF3CX5Hy991FJUl+k0MTSvE1iTXn+lwPH1TSEbPJXFNIAhiT19mw253E3SZ8VrX4VsbgnCARmepNqrwRxCGrMex/YJM2kQB9S/lVV0bvcA7clzhaIeEpg6H6yPYMiQe7n8CSp7x4B1Q1aF/cybypkQm/GIv+u/WGfQvF2FFWZqGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMc19bCpWzkVv1sj+dRk0zP3GtBh45Tt7Lgxo+DB25s=;
 b=Knxwac84MgRJ5WaxsnrV5a0mljPQowqx1g04PIgZJCgQ8ohtsVl8H9DwkBvIprz6XEM19QkGUJFKPLuhgF5O4r2TIryVNYixrQ0cSH/GNaN6CSoWIhXFxL8bONWN1CqP6s1t+wEw1AxO3zg8K0vqTN5pwv3pv+6C5am2E4/md8eqWJfcLyttjN1Xu1pHsg5ra9FmRnFyc6p/E6OSfe1c3tfxxyMG0dIL7llXlzTfHgTgl/AvePw90QILoKuHUEmXqQXUWqvTmbDx0VVw8v3SiLuAdEyOs3py/mmRv95YJpLY8xPaK2UmW0mA60WQJudl1WCTGxCA3j9R0JHkkG8HGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMc19bCpWzkVv1sj+dRk0zP3GtBh45Tt7Lgxo+DB25s=;
 b=AXxwne9Dtzho7CCB7GB9GbU4aPb4Xq3jh0tzVH95xOSQRvV+FQJQ2dS8neFtWVpgcbPYqBvt4laHwfV8c8j+mUkylV0dkueemcXyNpJv9FiiAPyu+YdP5fo3Vnxh9vILzyowXNTfMtvoXr3QJ7UMNaHpka24NW1KQZzbk4DFSaQ=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by BL1PR21MB3138.namprd21.prod.outlook.com (2603:10b6:208:396::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 04:04:01 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::4867:9c4e:6d50:9323]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::4867:9c4e:6d50:9323%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 04:04:01 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Optimize vmbus_on_event
Thread-Topic: [PATCH] Drivers: hv: vmbus: Optimize vmbus_on_event
Thread-Index: AQHYoAoueW63y7moXkuKWcsAMhIgaK2eJ72A
Date:   Thu, 4 Aug 2022 04:04:01 +0000
Message-ID: <BY3PR21MB30331D04EE8F21FE84902676D79F9@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9572c281-a7fa-47f2-ad9c-563c49ecf63e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-04T03:40:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf955b04-e51a-4391-0e90-08da75ce5d1d
x-ms-traffictypediagnostic: BL1PR21MB3138:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6A8Y0WLc1GysGUDzvDemZAL/IIUYD/rtz2AfjedAv+aJ9DzRpDrrnJbi27EXKHuTlQJu9wy3v5ypnm/oE6rqKXmTL6RuLGSGP+bCNqp/05SoyK41pW0NaD/C3zEesK4vlZAA7V8h3qWb/qEQ+U0Mp9lNDzlWcwOOta4S0Da08RG5IrpoalXCctzIoITIaDsiX+X+G8MJoo/wQdCkZREbyeJiQ6YkTEQwi9JnEmouz891TRDLIvsISeeMWXgxdmVl3GhXA87AAx5zowZjKqq5l8Wu5suj7BMCM1ZBKtdER2Skl5yqj10EY16QV9SeDkbeGX2cpEv7Vd/sh8834E75GYu2BxVO3NJzFKHHWIMo8TqygsBphpaORAVf51S2ztRwVsjq8T2fwvvV0W5oqn0yrBfrhzSLeU5v25eHhfSK9kzk3CxibYuuj6/eouGSGhpEO2beaQ2aNIx2PxcVsKImiOXyBwW0sVZs81KBOohbI5wjRoOZ0OoD+F/mbFjHEuXlPdz/qSE2kjlT0NHDm+unrJ6ls8Z1EQDe738L3CgP+LSzjKKfhPLS+M434N0LQFXp5m5Vftsx4zE8Vup03FZIV/gf9t0Y6DqSOayCUgudtcj7SXCvGZZeXInu4KC/JmDEOXTTbi1niZV6RB589uTqaNtxVAgtW0ECp5c4CkW+FEe1dl/Tm4TAAuRrsuiylQZQGpUZmLGDBUQybPCx4eTFKc4cC2lpmSyqYKl0igIFDlKw25DGNvZNuyCec3rp3ExA7Fkm1WeGz6Ajg7k4BXW9ZSlT8/Ddj1wOHxJeKEIxebhyUfJlE/B3qpNf+lj09WFAn7ARcZKfEBWUTE1/nIbddbmQJSFpoDYyXNeZNXJBqoPUVRfnoS6gJNzNmvAnDIe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199009)(8676002)(5660300002)(66946007)(76116006)(8990500004)(66556008)(66476007)(64756008)(55016003)(66446008)(52536014)(8936002)(2906002)(122000001)(38070700005)(82950400001)(82960400001)(33656002)(38100700002)(86362001)(316002)(921005)(41300700001)(478600001)(71200400001)(26005)(110136005)(10290500003)(83380400001)(9686003)(7696005)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+Og+OmnC4FoiwXuosuy5BWHwlZAdYp4WfBPGR/0a+QUe54ZQMsZjCY7VTU4?=
 =?us-ascii?Q?YsC3gwExqksy17L123ft9h28i3dsSQqHT1ktRs6YEFUFbnO9+ikpjV88KeOK?=
 =?us-ascii?Q?RFiYoEmm9yEgWa+sWPVTMQc3MLPevgEWtJC65tYfSsRcctrQeyEm0j+fJ5mp?=
 =?us-ascii?Q?Ju7TDYqbJIB0YQJ/hPMLykUvGmSahDaF0Gyq7q4uymqYRf6X18riyHh66oUY?=
 =?us-ascii?Q?qLKSlU7JV1d/EkUfq6Sk0Aqwlir7o0CPL+F5Nja/cbIkbuvU0ozUNppCzAcZ?=
 =?us-ascii?Q?MytQjge28pFTcDujO8l1MICe9W001D/eLYrpnEnq8XAeLjp3GF/9StHEiKea?=
 =?us-ascii?Q?/dzZ5LV9wls4kL2lvcCwWTW06oQDNN3I1iNVJ/xzsG9Jze+jHH+4ydModowB?=
 =?us-ascii?Q?Tqr9IKPnuobgexwxfBZDrks3mtLtJ080wnKV7l15EKpdXf1mlJCb08RmDycD?=
 =?us-ascii?Q?yjZJRylky0mC9GODq+WERPyTux0+biO0b8K1iNna/OWli7B8iIMYVHm4RTXG?=
 =?us-ascii?Q?Znm90Y5NTtmmLNwawAY5VNb33BaDJpg/t4LUHm+mPc4pBtGJIVeRSQUl1++t?=
 =?us-ascii?Q?tZcHbU66ZUxPzjlURDC11ikiQ2wIWjqXHzaCTQXTcLDqTh9FnZdN/CqsC2mf?=
 =?us-ascii?Q?HNsGrjnetIhgoYMsw7D6HRaQU2FhAOcRzKEq2ohRDejx1lzMbWgoD0R708p7?=
 =?us-ascii?Q?gRoMAT5BhYs8wBCjMqDxebrl4c99GJoTZ5R9idp7efZ8/vu/or4pmBx5QyfT?=
 =?us-ascii?Q?cPpbMmHxZHJ6ASKOe/n0PxOL9Nju9xQLCSggTZq5EsybZkh5UR1rrWyIea9b?=
 =?us-ascii?Q?jKg89E+an1f/rBSXRw777gYjjRlWjO5R/5Ou2f9HApXu7ZKBOHjDU0PL62N9?=
 =?us-ascii?Q?Cr7geYhlV8LQA1lDuNEBnUUgSJETgA3nt4lLxh8qgcJyXgTntIruQkg94C9l?=
 =?us-ascii?Q?T/gP8onWC0IrvoDHccXqYH7rVcEzkKLSrp5h66bxnFl+5UhB5m5HVaidl+nx?=
 =?us-ascii?Q?O2R153wAcbRjfwZm4lr4J1qngQGvx4WUPhRatFlMlDNM0QaIBP7aJKCHh50j?=
 =?us-ascii?Q?z+qosqmkoeRLyhMqNrMtLsAJrhwabHx9ZKoYPtuE3V5WA89IWO4wAcFLdGLt?=
 =?us-ascii?Q?pgrTfZ4xwppt0mOyy7bwk85IfCG9jAY848s90aPJcBg+TC4L04WksHUWyquy?=
 =?us-ascii?Q?FJKdgk8u7gFUllZ8rolTsu/L2Hbhj8mRsApzlhRYM3trJ2KjBS3Ijw57W7aK?=
 =?us-ascii?Q?UMRLvaN9/lBraHhKbtzAM4AeGsOBl/T3Onw6FnmIgFGxh99uxuml/BG8uNio?=
 =?us-ascii?Q?qtKf+Y4Kv2sEvg7seqchBiYuXnte1HEiD2zFW+xfQSGbpaMRzpD5ZpHcvlv3?=
 =?us-ascii?Q?F1AyRFat+MKPVkhTVqjJQNHPjRBxAlmS5ybm9mHw3fzQ9rOUwDRuT5GXdWeY?=
 =?us-ascii?Q?dnXhBNCOfl/ee2GVE9d9nF47hKFrsnF8Nj8BLjnRRJ0fkYI8MpXyEfsgBLZ7?=
 =?us-ascii?Q?JKH3qmTMhoO7FVgW6yTJnrtHqGXygBER6Fs7Mggc37AjdG7KPYUWoqyHmP5A?=
 =?us-ascii?Q?CoVVptkOAT+XW3YCYTaTqPmQ73ft5gp7X8E7iZdZPfT60pwRK+Uc3SNDtasL?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3138
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, July 25, 2=
022 2:37 AM
>=20
> In the vmbus_on_event loop, 2 jiffies timer will not serve the purpose if
> callback_fn takes longer. For effective use move this check inside of
> callback functions where needed. Out of all the VMbus drivers using
> vmbus_on_event, only storvsc has a high packet volume, thus add this limi=
t
> only in storvsc callback for now.
> There is no apparent benefit of loop itself because this tasklet will be
> scheduled anyway again if there are packets left in ring buffer. This
> patch removes this unnecessary loop as well.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/connection.c    | 33 ++++++++++++++-------------------
>  drivers/scsi/storvsc_drv.c |  9 +++++++++
>  2 files changed, 23 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index eca7afd..9dc27e5 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -431,34 +431,29 @@ struct vmbus_channel *relid2channel(u32 relid)
>  void vmbus_on_event(unsigned long data)
>  {
>  	struct vmbus_channel *channel =3D (void *) data;
> -	unsigned long time_limit =3D jiffies + 2;
> +	void (*callback_fn)(void *context);
>=20
>  	trace_vmbus_on_event(channel);
>=20
>  	hv_debug_delay_test(channel, INTERRUPT_DELAY);
> -	do {
> -		void (*callback_fn)(void *);
>=20
> -		/* A channel once created is persistent even when
> -		 * there is no driver handling the device. An
> -		 * unloading driver sets the onchannel_callback to NULL.
> -		 */
> -		callback_fn =3D READ_ONCE(channel->onchannel_callback);
> -		if (unlikely(callback_fn =3D=3D NULL))
> -			return;
> -
> -		(*callback_fn)(channel->channel_callback_context);
> +	/* A channel once created is persistent even when
> +	 * there is no driver handling the device. An
> +	 * unloading driver sets the onchannel_callback to NULL.
> +	 */
> +	callback_fn =3D READ_ONCE(channel->onchannel_callback);
> +	if (unlikely(!callback_fn))
> +		return;
>=20
> -		if (channel->callback_mode !=3D HV_CALL_BATCHED)
> -			return;
> +	(*callback_fn)(channel->channel_callback_context);
>=20
> -		if (likely(hv_end_read(&channel->inbound) =3D=3D 0))
> -			return;
> +	if (channel->callback_mode !=3D HV_CALL_BATCHED)
> +		return;
>=20
> -		hv_begin_read(&channel->inbound);
> -	} while (likely(time_before(jiffies, time_limit)));
> +	if (likely(hv_end_read(&channel->inbound) =3D=3D 0))
> +		return;
>=20
> -	/* The time limit (2 jiffies) has been reached */
> +	hv_begin_read(&channel->inbound);
>  	tasklet_schedule(&channel->callback_event);
>  }
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fe000da..c457e6b 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -60,6 +60,9 @@
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
>=20
> +/* channel callback timeout in ms */
> +#define CALLBACK_TIMEOUT               2
> +
>  /*  Packet structure describing virtual storage requests. */
>  enum vstor_packet_operation {
>  	VSTOR_OPERATION_COMPLETE_IO		=3D 1,
> @@ -1204,6 +1207,7 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  	struct hv_device *device;
>  	struct storvsc_device *stor_device;
>  	struct Scsi_Host *shost;
> +	unsigned long time_limit =3D jiffies + msecs_to_jiffies(CALLBACK_TIMEOU=
T);
>=20
>  	if (channel->primary_channel !=3D NULL)
>  		device =3D channel->primary_channel->device_obj;
> @@ -1224,6 +1228,11 @@ static void storvsc_on_channel_callback(void *cont=
ext)
>  		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) :
>  			sizeof(enum vstor_packet_operation);
>=20
> +		if (unlikely(time_after(jiffies, time_limit))) {
> +			hv_pkt_iter_close(channel);
> +			return;
> +		}
> +
>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
>  				"Invalid pkt: id=3D%llu, len=3D%u, minlen=3D%u\n",
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
