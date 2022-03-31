Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801344EE215
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Mar 2022 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiCaTtY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 31 Mar 2022 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiCaTtY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 31 Mar 2022 15:49:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469424059B;
        Thu, 31 Mar 2022 12:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgl3J6SkSuhk+fWmGKVVgUr7IeXctTiTW7YVuy08MKo51EL5QEvG0405T/bfwug5xliBo5SjTwU04X3oNlJJ16JnB7jJxg1cxJOMintlet+isoX7vD7R+ngVyP9uykfT/3hcjxnfEVrxlFAeEiszSEUsV9XUofb+KnXuQclTng4LcD//kwULcIXkT6GSL4npJMJIqI+RSIyhQO4bMRr1l6DCANt55JIplkZj4IjznkzD+vrbPRQG2GcOUy70HXpUdW6FN9mKqwoHkIpZrYe/KDfkYuqu8HbHvr4zWnLAhlrHbvw84IGElBqpMN6Go4NuVmTIEaWF2k4SWfyGALlumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nosk05GVNurNh1lVT+G90Oet8Eig7ZbE9adIXe9vruw=;
 b=C8bKNCmmSQGYqUz+YdRgrlJfyRUwXZEbuNSeadnYsopyrfijmc8ydb4IkhKXcAKpIkjplBfV/1XxSmf2WppWLg74X6u2lsPLr/atxlPzxxAf0yEXVzbbBo6POsWxhIOs9potD5gS1qIhMVX99hngMdFPawOaeU9CTWYsiW4ynliOI+ykdBZx0RPiHT90grKtGHwlIRZFVVBLatZNdNnt8SxCaagaOTE2ksoI/H8H5mFbfS7aJnHuIHF/WwvLfHzWy+bnwHZMupmKmV0zwhaHywSF3f/4IB+hv74NCFwGFGyYAeG4/nRJQ3wkkpyv0MoqGR90VEK0PuOFA2+ovqsg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nosk05GVNurNh1lVT+G90Oet8Eig7ZbE9adIXe9vruw=;
 b=hM1X5Lrckw2rA2+cFgpZcwQKYqn2G74vntRLQQVouS+kQ1s3LcENZ2FDYSnqmN/yPnugKUTZ/B3YAlBhjunF2rpb20K8IwnaDMaZaxdrAlOOA0Q1bud7AhOqBnJMxanzL4euSFM1A5JwKTDhHoYWyJbWuKu7u3zrOo3/ammkhj8=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM5PR2101MB1110.namprd21.prod.outlook.com (2603:10b6:4:a5::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.9; Thu, 31 Mar
 2022 19:47:33 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22%5]) with mapi id 15.20.5144.011; Thu, 31 Mar 2022
 19:47:33 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 3/4] Drivers: hv: vmbus: Introduce
 vmbus_sendpacket_getid()
Thread-Topic: [RFC PATCH 3/4] Drivers: hv: vmbus: Introduce
 vmbus_sendpacket_getid()
Thread-Index: AQHYQrIr8owmhjFajEK7f8RcR8eP46zZ6ThQ
Date:   Thu, 31 Mar 2022 19:47:32 +0000
Message-ID: <PH0PR21MB3025F80C3F90284900C3D128D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-4-parri.andrea@gmail.com>
In-Reply-To: <20220328144244.100228-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d76cdaaf-8326-48a1-9f04-8828409b7be3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-31T19:41:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3c6492-4217-439e-b598-08da134f4c61
x-ms-traffictypediagnostic: DM5PR2101MB1110:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR2101MB11106A9D4AECF6E91C7AC972D7E19@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtapmmPVsKYzcuV6FhcmVKhsuF+4+GkcaV4oRpBWTS3OMgGq4R2pBRav8S1NGZoPmfFB7tzYp6gvOOILQqcKD5Fpjq4gCMVutj/FY8qKZniJH+kNiKY9YClqbNlTvnWeawTy91atu7gDbfITCeWgETwLfJRcW/wmDFfDV/YIgOobJh1Xq8VkXYxJYi3inyzMkA5Z1RESYHYoGXKP6feTEurjDunXnN/swDUiCtS5GamwvDTqBt53GfXLQKsk7hcD+YXR2PEqgb2rwrTAcMCYYyFDrmgWv9Sol86Fise2pWKKlP2YlIFPnOxDlVtRPui8g7ZSi7pNzqFM9UvxLNRB+R19RfgyAfCRWO+T5Bc7+bCOXppvSrG5wXtahPKLOCvT55uUww3ouC+m+fVwu1zanBsm5Iuo5qCYHWaMH2meOXjnDmrNYIdh9QGYHbdce/i0eTNiBzWE+3yjI1Ec/ZrJiNWly8vIN6sAtN+YY6AucoW6dTvNCI3sLz32UwAhOzmiAUOPPypyAp8d75BYQdeuGRtryyMyvUXxMAwLFRHNmbS2V0/HVRJ1B82rJ7ErT+NSeVCgY/9zF+xeXkscgBfVhVqnrjC9wjOS7bEd+pXovAkc4jKiLiUgvrkogUjcqEzgk0Bx5rMudPBvl4RfDRPz+5EYnpyVD7k9OTTpz24UwOWY9irUoPSCdiLtjwCcD37f7dr2N2HjaNjVcHZWMarz/9A87lL8ZE+l+hVpjoAMJ/bms8CX49dY0XGn2r1PJt1GWR/kIbSRc1s2jZcemvEwHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66556008)(66446008)(4326008)(66476007)(76116006)(9686003)(66946007)(8676002)(52536014)(64756008)(86362001)(316002)(921005)(26005)(122000001)(8936002)(508600001)(10290500003)(38100700002)(54906003)(7696005)(38070700005)(6506007)(8990500004)(5660300002)(82960400001)(82950400001)(71200400001)(2906002)(55016003)(186003)(33656002)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YnONsQWmFtuWF8tNaTfBVb+Yrs2Ba7BaKBjT0U/eQi9Aj8BcdM6wpH54aDBY?=
 =?us-ascii?Q?S+GsHYrbwMJhG1Y5a9VgxviHv7nTuTL4ZB7jJK69hBKzFHBbXadZcNai3CDR?=
 =?us-ascii?Q?Mm8KoLtVGVEWFp8p/E0UaGnU0ydxmJkw8/Yk8/2FBS11h+baj1TQSevVAl+5?=
 =?us-ascii?Q?fruxWO6pZSowHaxjbZ+RRUf2IZncOFWdqS12sr6PkanIfh2ZaM4DvZu0Fxju?=
 =?us-ascii?Q?VnD6UDpsKMMD+lQfRLqDL16BEh3CAwhGAdWswATjVQ2gjNOyen+XjG9Ddggw?=
 =?us-ascii?Q?aTuRus1MTf/OsVmTodZk8WbU0HEwGctZJKNmKU+/iB3RTerj2Mb8LoJn5ZIa?=
 =?us-ascii?Q?YcGdwmvBXABr5PF3GKSf9rqb3EQES1skSqLDqYzu+AX+hqZpIuV5AYVbOdTz?=
 =?us-ascii?Q?gvimUt8U1Ez4L/SltFqiZCc6+dHjnVYsKSFq57M1ENPu9QN/mEiN1b6SWKqo?=
 =?us-ascii?Q?kzid4rqS+smm+Oh9VYzJseIQRk/Rc7dEQUlBoULmZkn6eJPOn/4ZRp3w4fH/?=
 =?us-ascii?Q?nTZuCZKTNuceLrh91ewRd63T0GOdc22UEiKV897WBrSQJuohx67Yck4clrR5?=
 =?us-ascii?Q?sBtPkRvCaXxj75dS7iHIBlr83TxSXc90WbZ0B1MpDFgsG0nC6F2QF/3VCntl?=
 =?us-ascii?Q?DsJXQ6OINtgWXnZNDuCZv8BJ8OSLOV5RJOpQieX54CJFm8XZhU96AVaEjsS1?=
 =?us-ascii?Q?lOZSeuF429TYoRnNqKLH4Z0JH36aY5VFK9UyCSKX42QY3B5milVBk3IFB5k8?=
 =?us-ascii?Q?YZd9BAE1EGdcBgh4N0VDInaalqONDxeK8Exw9S7ppB8l1rObI/pzwHgQCywW?=
 =?us-ascii?Q?x07ArKDOCOaQ/cSkvYz5D8oQSyTlPkhRLefdpMG0SvZ7E2mhWfHLC5g5p9SP?=
 =?us-ascii?Q?b9YmFkuDf2Y9UA93LYr/JEU6Zzgjt9lUHMFu0mkSII6JEhVIixjc78SCUWun?=
 =?us-ascii?Q?VLeS5zy1+aHtTmF4o1J4tWHOzPBN6uNx0GBY4cFnI/Q/tCB+RHx0XwSOSEW/?=
 =?us-ascii?Q?gAqr0ZQGS1M8V+2C7usaNwz3Tffvrijs3GHtjGVZb2aIePhHenhj0KNzC8Jr?=
 =?us-ascii?Q?T0fIpjQtJ8gCsVJjiVbtkdNK3pX8nVdPjMi04NuIZEiSaxbMiNu/dtCIYMdB?=
 =?us-ascii?Q?fyAhj5F3uYTjhbnKnPq0gwZuqlBuYMMfLgvGiwiJMqdbP5ZSR3EYS4m9LoH9?=
 =?us-ascii?Q?yUQNI0vWueiHb860b7b6r1O7DaPF8AwLy9a1iR9O8bWDEQs9fsiW9HY/YIbk?=
 =?us-ascii?Q?RQezZ6ExUaC/T5S+k82oGPdOAvkpj+/ryTBjyWUorOuaDdVfGbaYvszDJ3jm?=
 =?us-ascii?Q?M+Fu9RAFDUTBDeKdIFvsCuzLNCGxV8Givaifuxh85uG8+asyUaJx/RC3rDar?=
 =?us-ascii?Q?B9AwAqZqWDTVEE7aXiRo4IIFt3kixgFSSPoOoOf/BPTmzUR9hkTtBBZdyKUV?=
 =?us-ascii?Q?qYbvwHTLAwknOvZWYP+TdsOXbLj0UINsaEQSeP/bBgvR+vYvnjoVXuq7JhQr?=
 =?us-ascii?Q?lf+GsjlkbeqhPY6cHzpQ4nm/IvsrRr/g4faA3Reufqi2VIR6Wvb4mVZWh4r8?=
 =?us-ascii?Q?0JuPsC3oEHLhgTyQzaLqWcHJP2zaaJMDRXafECOCs47oknl1e16aQqcXZV2W?=
 =?us-ascii?Q?VVpa/YwlN5kzrnscdR9m8i6J4ubmkRrv1KhXj/rmkOAgh/+YhSL/F2nKj44Q?=
 =?us-ascii?Q?qs6vbh0qvDS05gsmzbIW3WY1KVV+YfytGLLg6UUnz3WFGdRAJgRXbGTu/zPD?=
 =?us-ascii?Q?yAqH8oVCEosGFpXi3xOlKB5eNkGP/Tg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3c6492-4217-439e-b598-08da134f4c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 19:47:32.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYDGzGVBZuEMDmBYQmMsbK9IERM4p2lzeRKK4cvKRYZOmPXomYGbyU8E321sqShIQRHqpP3ig4VbZ1RGNmgyXJlfc2mTwP7YPFVOm22sQmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, March=
 28, 2022 7:43 AM
>=20
> The function can be used to send a VMbus packet and retrieve the
> corresponding transaction ID.  It will be used by hv_pci.
>=20
> No functional change.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      | 38 ++++++++++++++++++++++++++++++++------
>  drivers/hv/hyperv_vmbus.h |  2 +-
>  drivers/hv/ring_buffer.c  |  4 +++-
>  include/linux/hyperv.h    |  7 +++++++
>  4 files changed, 43 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index a253eee3aeb1a..3eaa41c7ce15f 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1022,11 +1022,13 @@ void vmbus_close(struct vmbus_channel *channel)
>  EXPORT_SYMBOL_GPL(vmbus_close);
>=20
>  /**
> - * vmbus_sendpacket() - Send the specified buffer on the given channel
> + * vmbus_sendpacket_getid() - Send the specified buffer on the given cha=
nnel
>   * @channel: Pointer to vmbus_channel structure
>   * @buffer: Pointer to the buffer you want to send the data from.
>   * @bufferlen: Maximum size of what the buffer holds.
>   * @requestid: Identifier of the request
> + * @trans_id: Identifier of the transaction associated to this request, =
if
> + *            the send is successful; undefined, otherwise.
>   * @type: Type of packet that is being sent e.g. negotiate, time
>   *	  packet etc.
>   * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
> @@ -1036,8 +1038,8 @@ EXPORT_SYMBOL_GPL(vmbus_close);
>   *
>   * Mainly used by Hyper-V drivers.
>   */
> -int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
> -			   u32 bufferlen, u64 requestid,
> +int vmbus_sendpacket_getid(struct vmbus_channel *channel, void *buffer,
> +			   u32 bufferlen, u64 requestid, u64 *trans_id,
>  			   enum vmbus_packet_type type, u32 flags)
>  {
>  	struct vmpacket_descriptor desc;
> @@ -1063,7 +1065,31 @@ int vmbus_sendpacket(struct vmbus_channel *channel=
,
> void *buffer,
>  	bufferlist[2].iov_base =3D &aligned_data;
>  	bufferlist[2].iov_len =3D (packetlen_aligned - packetlen);
>=20
> -	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid);
> +	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid, tr=
ans_id);
> +}
> +EXPORT_SYMBOL(vmbus_sendpacket_getid);
> +
> +/**
> + * vmbus_sendpacket() - Send the specified buffer on the given channel
> + * @channel: Pointer to vmbus_channel structure
> + * @buffer: Pointer to the buffer you want to send the data from.
> + * @bufferlen: Maximum size of what the buffer holds.
> + * @requestid: Identifier of the request
> + * @type: Type of packet that is being sent e.g. negotiate, time
> + *	  packet etc.
> + * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
> + *
> + * Sends data in @buffer directly to Hyper-V via the vmbus.
> + * This will send the data unparsed to Hyper-V.
> + *
> + * Mainly used by Hyper-V drivers.
> + */
> +int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
> +		     u32 bufferlen, u64 requestid,
> +		     enum vmbus_packet_type type, u32 flags)
> +{
> +	return vmbus_sendpacket_getid(channel, buffer, bufferlen,
> +				      requestid, NULL, type, flags);
>  }
>  EXPORT_SYMBOL(vmbus_sendpacket);
>=20
> @@ -1122,7 +1148,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channe=
l
> *channel,
>  	bufferlist[2].iov_base =3D &aligned_data;
>  	bufferlist[2].iov_len =3D (packetlen_aligned - packetlen);
>=20
> -	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
> +	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
>=20
> @@ -1160,7 +1186,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel
> *channel,
>  	bufferlist[2].iov_base =3D &aligned_data;
>  	bufferlist[2].iov_len =3D (packetlen_aligned - packetlen);
>=20
> -	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
> +	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 3a1f007b678a0..64c0b9cbe183b 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -181,7 +181,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info
> *ring_info);
>=20
>  int hv_ringbuffer_write(struct vmbus_channel *channel,
>  			const struct kvec *kv_list, u32 kv_count,
> -			u64 requestid);
> +			u64 requestid, u64 *trans_id);
>=20
>  int hv_ringbuffer_read(struct vmbus_channel *channel,
>  		       void *buffer, u32 buflen, u32 *buffer_actual_len,
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 71efacb909659..c8561c80c460c 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -283,7 +283,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info
> *ring_info)
>  /* Write to the ring buffer. */
>  int hv_ringbuffer_write(struct vmbus_channel *channel,
>  			const struct kvec *kv_list, u32 kv_count,
> -			u64 requestid)
> +			u64 requestid, u64 *trans_id)
>  {
>  	int i;
>  	u32 bytes_avail_towrite;
> @@ -354,6 +354,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  	}
>  	desc =3D hv_get_ring_buffer(outring_info) + old_write;
>  	desc->trans_id =3D (rqst_id =3D=3D VMBUS_NO_RQSTOR) ? requestid : rqst_=
id;
> +	if (trans_id)
> +		*trans_id =3D desc->trans_id;

This line should *not* read the trans_id out of the ring buffer, since that
memory is shared with the Hyper-V host and subject to being maliciously
changed by the host.  Need to set *trans_id only from local variables, and
somehow ensure the compiler doesn't generate code that reads the value
from the ring buffer.  Maybe mark the desc->trans_id field as volatile, or =
cast
it as such?  Or does WRITE_ONCE() work when setting it?

Michael

>=20
>  	/* Set previous packet start */
>  	prev_indices =3D hv_get_ring_bufferindices(outring_info);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index fe2e0179ed51e..a7cb596d893b1 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1161,6 +1161,13 @@ extern int vmbus_open(struct vmbus_channel *channe=
l,
>=20
>  extern void vmbus_close(struct vmbus_channel *channel);
>=20
> +extern int vmbus_sendpacket_getid(struct vmbus_channel *channel,
> +				  void *buffer,
> +				  u32 bufferLen,
> +				  u64 requestid,
> +				  u64 *trans_id,
> +				  enum vmbus_packet_type type,
> +				  u32 flags);
>  extern int vmbus_sendpacket(struct vmbus_channel *channel,
>  				  void *buffer,
>  				  u32 bufferLen,
> --
> 2.25.1

