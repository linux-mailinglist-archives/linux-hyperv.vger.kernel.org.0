Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85E322A01F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jul 2020 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGVTZR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 15:25:17 -0400
Received: from mail-co1nam11on2115.outbound.protection.outlook.com ([40.107.220.115]:41185
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgGVTZQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 15:25:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw8x2pIyhTBVAzHyUclFAyblvIB8XsEJupS4FPTvTtVjrwtnBG/7q5WD6ayx3Q67bKypIK2iXQUG2XDIv0qQnhatZksMN0q9HT4IJhP30ddzjWEeepfYFeEDOq3HY5Lmf9/MMY72YTFsxTaRLgzvdS/CXSLaa1Y5qQ9m6KwuDIN82AM9VifUPvmpj83j1WXnyUT9UcS9L9xWQMC79qqx9ATGv82vLz7SnYgJOJQURr24He02ObgNCVEm4xkMgzaaH87AUk0gEP3MHknm5p3idYs6uNLwVDcSe5hz/GIln2NMDNGyMjYxPa6SRmabnFlGWcEv0OJJFdbmtL59ssvMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4Nm60oRUhUYskA9vD2+SBUXmzn7o14G0qFyVHmrY90=;
 b=gFJAqqS8f1r/dn7iEQRCjKsfv5luvIAM8+5pJIic6o2XteVXCdeCDrE7HAhS70kPFJ7PR8p8zc/Q/eHwb4yxaVMYHJ19Uedi/3dY5rXnptL8J74GbOVXsMNaEOqSAmJCSoYF9+QmIVsVstAVYKaKnp/KpcHU/ozBRFkxrKMHuTiiL0hlCrPDQnAmrlXTORq0QV9O/xazCFLNy2C8KMZB5sGwO+IFKVJeR2A5CQhLyJRnIYMKt8CucldSKujHA+qevRcjKybNUH/kzcwj+4TIMAApdeqYOtdYrK53PRDXFzH8LYOZeZRwQbPpfvtMSVaQ2g0wAq32/jqfuOkheBP+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4Nm60oRUhUYskA9vD2+SBUXmzn7o14G0qFyVHmrY90=;
 b=DiyKIj4O+LF47R97PzNgeI3MarCtvP+N1dyoYsB4hwlyzdDRxOME93dFjtb+MiZWDw5QiO+oF876fn7NLCwM3opszSs9ySfgMNInu2PPisK9NU2DqmAHLd8/wGLEn9FcOGw2cI3tYALLBYSvLHCYJwYcP+064Vy3rSHDtFccvjY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR2101MB0810.namprd21.prod.outlook.com (2603:10b6:301:78::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.3; Wed, 22 Jul
 2020 19:25:12 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3239.005; Wed, 22 Jul 2020
 19:25:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: RE: [PATCH v5 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v5 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWYFNyHj2wRUmHT0OFH7kIFlRijKkT9s0w
Date:   Wed, 22 Jul 2020 19:25:12 +0000
Message-ID: <MW2PR2101MB105231CB8AE6BE0E8BD6A535D7790@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200722181051.2688-1-lkmlabelt@gmail.com>
 <20200722181051.2688-2-lkmlabelt@gmail.com>
In-Reply-To: <20200722181051.2688-2-lkmlabelt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-22T19:25:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3351fb0d-71db-4b50-a619-e5a58c7848be;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f776c52a-9ad4-4954-41d0-08d82e74f473
x-ms-traffictypediagnostic: MWHPR2101MB0810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0810A9781EB3B48A3701914BD7790@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpWuDfOwReliBB1eptEPRQEf2YwdnUymE/KGHN5mwtaAUPo7F3RyxLBznrvV51r/OyzG+FQUiIlzQ+csfjMP4jU5vR5CM6BvOpsmwXHTOHYjhV/HgXjhKRgXVxg3g/jEmgvHhXdSuIn8XLuUmzcjpNcb7FWUi+djWDAvX7NaaCh2Us/mgu1yxEriK6vIZfJ8iOTIZNtmAndCUNN4UCNUTt2NMUkaU79C6u1r/zRnyxjmDhh6sO9Jzz4dvxD0/KpKg1KBdfZndq3bPpiO1E5nJc1fl1byLt9zRiO7gIFQLIF2yRx/Xoww1v4fdeTFI5fm2jbpyoPPpOL/fGvlLUIBwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(86362001)(26005)(5660300002)(33656002)(9686003)(4326008)(83380400001)(186003)(71200400001)(8936002)(10290500003)(82960400001)(8676002)(66446008)(76116006)(64756008)(7696005)(66476007)(66556008)(316002)(6506007)(2906002)(66946007)(52536014)(55016002)(82950400001)(110136005)(478600001)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xi58ZBnmcjGxMdAJsKebpVg990m3xcV0YfK9Wd/62qyxYdt7Rva8++tFjai+jb1KZvi5YAs/URDtpyrLia87ixBnmp5RUiaINVKLIqTRWqgSExYm4+9evHLlJs3dR8SsNNojFMPe/NIqjIIA3ST3DKSaYw0GFCX9UhLJW5HQSw4VjA8delJF8+/5y8b5afbyBybSM2QH8PMpXG7yIDVKFFvOmd5ORkJ8fTxVEt2lXlrMW3P1DlxJPovtX/R0nqyOGhioQze6rF8b820PaqfLwmux7WfPUAWET8WmD68yl8lITpjfxTkq7qp/0Kdvo/D80IwJ8tSCpJhhcbpZFy5a/KVf7RVg2wTmIYLCwF0AMh6/vym/PXIjokjzvY2vGJZWwpGxS5gCkUy3R8jleLVspSRokBNakERaxCmOqyvTnAN9tHStnCcq+cKuIc2XTVxjukE8qbcEYqfFB0UDr34dKijTsc9/sXcAHZDWIXW/Q2XBlMiVm+kTKrPZZHsI8VqJnLPDjQME1Lpar6xN/Gq1hOXlDs454vyVoPux+hREhX2dZyvZVnhQDrTcPEBofvh4F6lD0gMJGcAqioQTqDhskcTNzUIT2GQ4D0gP68Ofh+NJvrJnjDyx7akGQ6AsynXrWPBg4/a7AgisLnB5iFAXsA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f776c52a-9ad4-4954-41d0-08d82e74f473
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 19:25:12.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1Op9XiqHjShd7Sy26hS1uq2+sfHMGl6sqfUdmfi5O2//Ol7fkOvGnGcCOFWwR8is1yCTZ6matc4xdFOLOBmwZ8FBbi5r3xgqDNIR/4kgqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com> Sent: Wednesday, July 22, 2020 1=
1:11 AM
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
> Changes in v5:
> 	- Add support for unsolicited messages sent by the host with a
> 	  request ID of 0.
> Changes in v4:
>         - Use channel->rqstor_size to check if rqstor has been
>           initialized.
> Changes in v3:
>         - Check that requestor has been initialized in
>           vmbus_next_request_id() and vmbus_request_addr().
> Changes in v2:
>         - Get rid of "rqstor" variable in __vmbus_open().
>=20
>  drivers/hv/channel.c   | 175 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |  21 +++++
>  2 files changed, 196 insertions(+)

These changes do indeed solve the previously reported problem, which
is good.  I've tested on my own WSLv2 installation, and everything works.
But see comments further down.

>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 3ebda7707e46..b0a607ec4a37 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -112,6 +112,71 @@ int vmbus_alloc_ring(struct vmbus_channel *newchanne=
l,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_alloc_ring);
>=20
> +/**
> + * request_arr_init - Allocates memory for the requestor array. Each slo=
t
> + * keeps track of the next available slot in the array. Initially, each
> + * slot points to the next one (as in a Linked List). The last slot
> + * does not point to anything, so its value is U64_MAX by default.
> + * @size The size of the array
> + */
> +static u64 *request_arr_init(u32 size)
> +{
> +	int i;
> +	u64 *req_arr;
> +
> +	req_arr =3D kcalloc(size, sizeof(u64), GFP_KERNEL);
> +	if (!req_arr)
> +		return NULL;
> +
> +	for (i =3D 0; i < size - 1; i++)
> +		req_arr[i] =3D i + 2;

I don't think the above does what you want.  The allocated
array ends up as follows:

Slot 0 contains "2"
Slot 1 contains "3"
...
Slot size-2 contains size
Slot size-1 contains U64_MAX

This means that allocating the next-to-last entry will go
awry.  I think the previous version of the slot initialization
code will actually work just fine.

> +
> +	/* Last slot (no more available slots) */
> +	req_arr[i] =3D U64_MAX;
> +
> +	return req_arr;
> +}
> +
> +/*
> + * vmbus_alloc_requestor - Initializes @rqstor's fields.
> + * Start the ID count at 1 because Hyper-V can send an unsolicited messa=
ge
> + * with request ID of 0.
> + * @size: Size of the requestor array
> + */
> +static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 siz=
e)
> +{
> +	u64 *rqst_arr;
> +	unsigned long *bitmap;
> +
> +	rqst_arr =3D request_arr_init(size);
> +	if (!rqst_arr)
> +		return -ENOMEM;
> +
> +	bitmap =3D bitmap_zalloc(size, GFP_KERNEL);
> +	if (!bitmap) {
> +		kfree(rqst_arr);
> +		return -ENOMEM;
> +	}
> +
> +	rqstor->req_arr =3D rqst_arr;
> +	rqstor->req_bitmap =3D bitmap;
> +	rqstor->size =3D size;
> +	rqstor->next_request_id =3D 1;
> +	spin_lock_init(&rqstor->req_lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * vmbus_free_requestor - Frees memory allocated for @rqstor
> + * @rqstor: Pointer to the requestor struct
> + */
> +static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
> +{
> +	kfree(rqstor->req_arr);
> +	bitmap_free(rqstor->req_bitmap);
> +}
> +
>  static int __vmbus_open(struct vmbus_channel *newchannel,
>  		       void *userdata, u32 userdatalen,
>  		       void (*onchannelcallback)(void *context), void *context)
> @@ -132,6 +197,12 @@ static int __vmbus_open(struct vmbus_channel *newcha=
nnel,
>  	if (newchannel->state !=3D CHANNEL_OPEN_STATE)
>  		return -EINVAL;
>=20
> +	/* Create and init requestor */
> +	if (newchannel->rqstor_size) {
> +		if (vmbus_alloc_requestor(&newchannel->requestor, newchannel->rqstor_s=
ize))
> +			return -ENOMEM;
> +	}
> +
>  	newchannel->state =3D CHANNEL_OPENING_STATE;
>  	newchannel->onchannel_callback =3D onchannelcallback;
>  	newchannel->channel_callback_context =3D context;
> @@ -228,6 +299,7 @@ static int __vmbus_open(struct vmbus_channel *newchan=
nel,
>  error_clean_ring:
>  	hv_ringbuffer_cleanup(&newchannel->outbound);
>  	hv_ringbuffer_cleanup(&newchannel->inbound);
> +	vmbus_free_requestor(&newchannel->requestor);
>  	newchannel->state =3D CHANNEL_OPEN_STATE;
>  	return err;
>  }
> @@ -703,6 +775,9 @@ static int vmbus_close_internal(struct vmbus_channel =
*channel)
>  		channel->ringbuffer_gpadlhandle =3D 0;
>  	}
>=20
> +	if (!ret)
> +		vmbus_free_requestor(&channel->requestor);
> +
>  	return ret;
>  }
>=20
> @@ -937,3 +1012,103 @@ int vmbus_recvpacket_raw(struct vmbus_channel *cha=
nnel,
> void *buffer,
>  				  buffer_actual_len, requestid, true);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
> +
> +/*
> + * vmbus_requestor_hash_idx - Returns the index in the requestor array
> + * that rqst_id maps to.
> + */
> +static inline u64 vmbus_requestor_hash_idx(const u64 rqst_id)
> +{
> +	return rqst_id - 1;
> +}

The overall scheme you are using to handle the 0 transactionID is
a good one.  Basically the slot array is still tracking values 0 thru
size-1, but what is presented to the calling VMbus driver is values
in the range 1 thru size.  That way you can recognize 0 as a special case.
So take this implementation approach:
*  Start with the previous version of the vmbus_next_request_id()
and vmbus_request_addr() code.
*  In vmbus_next_request_id(), just return current_id+1 instead of
current_id.
* In vmbus_request_addr(), add the new code that checks trans_id
for 0 and returns immediately.  Otherwise, decrement trans_id by 1
and proceed with the existing code.

With this approach, none of the initialization code needs to change.
Everything uses values in the range 0 to size-1, except that what is
presented to the VMbus drivers is shifted higher by 1.

Hopefully, I'm thinking about this correctly.

Michael

> +
> +/*
> + * vmbus_next_request_id - Returns a new request id. It is also
> + * the index at which the guest memory address is stored.
> + * Uses a spin lock to avoid race conditions.
> + * @rqstor: Pointer to the requestor struct
> + * @rqst_add: Guest memory address to be stored in the array
> + */
> +u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)
> +{
> +	unsigned long flags;
> +	u64 current_id, idx;
> +	const struct vmbus_channel *channel =3D
> +		container_of(rqstor, const struct vmbus_channel, requestor);
> +
> +	/* Check rqstor has been initialized */
> +	if (!channel->rqstor_size)
> +		return VMBUS_RQST_ERROR;
> +
> +	spin_lock_irqsave(&rqstor->req_lock, flags);
> +	current_id =3D rqstor->next_request_id;
> +	idx =3D vmbus_requestor_hash_idx(current_id);
> +
> +	/* Requestor array is full */
> +	if (current_id > rqstor->size) {
> +		current_id =3D VMBUS_RQST_ERROR;
> +		goto exit;
> +	}
> +
> +	rqstor->next_request_id =3D rqstor->req_arr[idx];
> +	rqstor->req_arr[idx] =3D rqst_addr;
> +
> +	/* The already held spin lock provides atomicity */
> +	bitmap_set(rqstor->req_bitmap, idx, 1);
> +
> +exit:
> +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	return current_id;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_next_request_id);
> +
> +/*
> + * vmbus_request_addr - Returns the memory address stored at @trans_id
> + * in @rqstor. Uses a spin lock to avoid race conditions.
> + * @rqstor: Pointer to the requestor struct
> + * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
> + * next request id.
> + */
> +u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id)
> +{
> +	unsigned long flags;
> +	u64 req_addr, idx;
> +	const struct vmbus_channel *channel =3D
> +		container_of(rqstor, const struct vmbus_channel, requestor);
> +
> +	/* Check rqstor has been initialized */
> +	if (!channel->rqstor_size)
> +		return VMBUS_RQST_ERROR;
> +
> +	/* Hyper-V can send an unsolicited message with tid of 0 */
> +	if (!trans_id)
> +		return trans_id;
> +
> +	spin_lock_irqsave(&rqstor->req_lock, flags);
> +
> +	/* Invalid trans_id */
> +	if (trans_id > rqstor->size) {
> +		req_addr =3D VMBUS_RQST_ERROR;
> +		goto exit;
> +	}
> +
> +	idx =3D vmbus_requestor_hash_idx(trans_id);
> +
> +	/* Invalid trans_id: empty slot */
> +	if (!test_bit(idx, rqstor->req_bitmap)) {
> +		req_addr =3D VMBUS_RQST_ERROR;
> +		goto exit;
> +	}
> +
> +	req_addr =3D rqstor->req_arr[idx];
> +	rqstor->req_arr[idx] =3D rqstor->next_request_id;
> +	rqstor->next_request_id =3D trans_id;
> +
> +	/* The already held spin lock provides atomicity */
> +	bitmap_clear(rqstor->req_bitmap, idx, 1);
> +
> +exit:
> +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	return req_addr;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_request_addr);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 38100e80360a..c509d20ab7db 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -716,6 +716,21 @@ enum vmbus_device_type {
>  	HV_UNKNOWN,
>  };
>=20
> +/*
> + * Provides request ids for VMBus. Encapsulates guest memory
> + * addresses and stores the next available slot in req_arr
> + * to generate new ids in constant time.
> + */
> +struct vmbus_requestor {
> +	u64 *req_arr;
> +	unsigned long *req_bitmap; /* is a given slot available? */
> +	u32 size;
> +	u64 next_request_id;
> +	spinlock_t req_lock; /* provides atomicity */
> +};
> +
> +#define VMBUS_RQST_ERROR U64_MAX
> +
>  struct vmbus_device {
>  	u16  dev_type;
>  	guid_t guid;
> @@ -940,8 +955,14 @@ struct vmbus_channel {
>  	u32 fuzz_testing_interrupt_delay;
>  	u32 fuzz_testing_message_delay;
>=20
> +	/* request/transaction ids for VMBus */
> +	struct vmbus_requestor requestor;
> +	u32 rqstor_size;
>  };
>=20
> +u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)=
;
> +u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id);
> +
>  static inline bool is_hvsock_channel(const struct vmbus_channel *c)
>  {
>  	return !!(c->offermsg.offer.chn_flags &
> --
> 2.25.1

