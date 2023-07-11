Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0762B74E5DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jul 2023 06:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGKEe3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Jul 2023 00:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGKEe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Jul 2023 00:34:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D636BF;
        Mon, 10 Jul 2023 21:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp3458MrmigLOBcMQnseFVXfGFPdlbgBQXVfGq/NDMUUNI9hVxMZZqO++1PsB1b5M5YAuM2niEPYxOB13RuS+bdmBtjDGduDA2XKGQd6nO2qukTlqZBbKnSAt2DIaS78Nm+nehr1BUjRPIXMEO7MyEv/CuxJZTlhc00tsa611q73JJXVKCBdC0xskAk/1GlWfuXS8Rnoa+mplRARkNF5cD14qWrXXHX8LdY/uNSeZoOzy1bqM8bjeYuYl8q5Y+AItfNSDyolLGeliaPbLfMQkHnqTgUKR5r4lC5Eab+qmN/R3yrRyeqvQPIoAaw/3wZSySdaxXTgI2184gT/pfw+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW3ai0GuT3IOwZ5S9uTLQiSsRshdMrFR/9pY9kdpTH4=;
 b=XsB61HGvcx1lBv6nqG4AFrkV7gTiA+F69u2NfVNjucyI/cp+K0P4eEGaPAkvZrgIkRM5DArWdtIPKbuaV2aygCx7wfzy9uajNrXsadUIQ6FawGOeDwbX244evMYywcqk7Zt/XEAwNtmYeTmYbOxe79U8rnJD4znCS0VJe0VcwNCGCWqrqPH0x7k8z/tGFmjKqwS8M8uf/yQNd+96AcjZjRQ6NM3YCdJmTgzw3KgUelNCdLcB3ZtEJAIjmrwwYg/rplbVLsndUCeIe/6YV1cohGguyDxmMvYMA7u4RyVxQShrs3WtS8P4cDqzrLfidWiXvtMQCQKx7w3I2ECtvmSitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW3ai0GuT3IOwZ5S9uTLQiSsRshdMrFR/9pY9kdpTH4=;
 b=CWDKNfzW//5zfrfo9Cz28Mnvh4Imy4h+2ZwjAvgRH3EIH1a3jLC1W7zjpblcBRnb9a4DjDO0WW14nk5184L8x1miH9q3r541zQ3rZ71XbUV6gr+vyOVVKQR6cy6Ty30n4MFDruJY/g3oPwugGUUgdjLax9hTfQ5YxJxrCqjB6zQ=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by PSAP153MB0453.APCP153.PROD.OUTLOOK.COM (2603:1096:301:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.6; Tue, 11 Jul
 2023 04:34:14 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7%6]) with mapi id 15.20.6609.003; Tue, 11 Jul 2023
 04:34:14 +0000
From:   Souradeep Chakrabarti <schakrabarti@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH V2 net] net: mana: Configure hwc timeout
 from hardware
Thread-Topic: [EXTERNAL] Re: [PATCH V2 net] net: mana: Configure hwc timeout
 from hardware
Thread-Index: AQHZsLfMxaLpIJMUVUSipb65VstWea+uFumAgAXpSpA=
Date:   Tue, 11 Jul 2023 04:34:14 +0000
Message-ID: <PUZP153MB07885FF6CC0FB6CECBC811B5CC31A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
 <2023070713-subway-stony-9ae1@gregkh>
In-Reply-To: <2023070713-subway-stony-9ae1@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a98c45bc-01f7-4bbf-abc7-9789eeff099f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-11T04:33:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|PSAP153MB0453:EE_
x-ms-office365-filtering-correlation-id: 74f4a3cd-6c0f-4e7b-ed6c-08db81c81487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWOjZb9haR1g845rgfAullSxUeyGm8AUQT2iYzbcL44iF783kvoBbG9zTPg86wdMBmmyAPGnp5LLY+icEBKaHlNIfRUfpX0WsKOa3SSA3J8u1B9u+VwiGVYyFuWPTKBFcCB3QF5WgUQrdWqLjBmKqUTOAVBUcYKUNiA0SWsUozqCOg01P4yvv0iZ10FHz+hFQDIdvgoLi3fonuuKO5clSwZeVfDzXM6eALrifmVfJwlCPQUJOdg+7Jg1H59Fzx6F0j5bNCgmHNEP16y/3qpryCXLyJQL62HjuI+DJixDqdyQf1hTVDVecolZdd3qtJU4Ar5Bxh0LQICOt5JOgkIIiZa99zd7G1ZqNlJdv55cnOPen42PrWfSdEs4bziJQfMQ/aUq19VdoIzndLu99EG2ca8Ccq+gjcoAe2yxxhRAR3/jnnpmbYbjnFkhK8dTPdRieqsTEtBxfT0QZurBhA7fRx4QW8aLK7g6onblDoALezOdFFYDhEtRuMVofaVQ1P9Ef/fTqNEaPxyTci/lK07kdRt92PeEdYuAcIR40vbk2FRewhoETiVl+UiUOwb8g2nCe4IomyJjNrfkwzsACGp2vzpRHq6cRjpWQ9SP5wUNAyhSAkla1c08H7TJBWuHTpA3l/Nbdfrljlw0sO5IQFg5R9Z9QujrUNQOKvzZ2KQ5sYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(38070700005)(33656002)(86362001)(55016003)(38100700002)(122000001)(82960400001)(82950400001)(10290500003)(478600001)(110136005)(71200400001)(8990500004)(54906003)(7696005)(9686003)(8676002)(8936002)(5660300002)(7416002)(52536014)(2906002)(316002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(6506007)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XVv05kDwWCoIE1EvzBup4/XTpcCOd5KiwCLjPuv6WanbirgXNOyZBNhgKm6m?=
 =?us-ascii?Q?dWoZUYXEZGQZH03PXED0YjCTGbKJFXsvxq1Ah1k+591208I09sMgDUz7gv1Q?=
 =?us-ascii?Q?7bM8MVJcdVqkHcLrc1VB23jIyZ26GfvKXpXydIkHzwg1VEOp1LzNcrlxd7w0?=
 =?us-ascii?Q?ZQQMqxO6RJbgGYSM/AID2GmiD5AdN6SHzLZv9AgZeV52bDK+9pwuPJuzI3yE?=
 =?us-ascii?Q?Avtg/Dqmxc1tHfnFCFSciR5arfaz0JO21UfukCK2AA3ciYHNlkQStK+iZ7G9?=
 =?us-ascii?Q?7ghNxzNSg3MLqv+EboqJGl4bz4uoTGL8pa0VS4i3+vsZaQD18cI977UYAv6Y?=
 =?us-ascii?Q?upb7Qb4t0HTXwYUJu+pL2cVt6W028kRYOPlIJL4NynWkDai76lYvj4DIAkCv?=
 =?us-ascii?Q?FNmORSWEAO2YoVdGuwS6bFYPKApfA1ARL2F63TJGys3M8Gv97zzlNB9+iOGs?=
 =?us-ascii?Q?F/6Z4E8rEeXqW9ipv8d0jpZ/0EUOIOUZL9nlg3a/YPRCeWjmuBiq/n9mrm8G?=
 =?us-ascii?Q?QF7vsLDt5ee0MgaLeCHbi/te5B8WRGEkwrRGG3XF9H5DhT8MIoamm/uHuh2N?=
 =?us-ascii?Q?xKLiB2swRVwowOjNtQOqcqvZABQ/rWbvZSwIsQ6I7Xe9lUNPsRSuqaxf/EHO?=
 =?us-ascii?Q?lGuB3mnQ6ODMYY36e6HW9Nl+lhTmXE2ue3kr/YXfAhf1u288Ao3Y3JWLOolA?=
 =?us-ascii?Q?Fce/1OYZPm7ejkRfAne+eCDd/5Vfsq/hSp9cG4L9Ix3u6wGDgIwdxIvV6IBj?=
 =?us-ascii?Q?8ZNZN0I/MJhv2q/Mswok//zy6BdTzIp8vs+s9oYPq+Wkp/Nx+wupd5WhW9E3?=
 =?us-ascii?Q?84oiENVDJnGLfxMe3G3MNoSaF+6bWRq7RsTM4n+2ACE00FMW2n8d+8dTMXCp?=
 =?us-ascii?Q?0L/rWDzaqTEzwsYZ1fuK5ocQfFc4E8kKqiKP8q+LuSAmgS+0MhyA6V32ZQrk?=
 =?us-ascii?Q?pDMynTmqhPG5ltXh/+ieiAciZLjip+ngHTNYrYfKaVth//VwaNci8HvD0xpl?=
 =?us-ascii?Q?Cv8hy40LbO3ZosbWOcMik6jwdYI3nACNIs1eSxaRkCDswkH++K0cJP9tDxK3?=
 =?us-ascii?Q?ZW3RfsXEQiQGuP+n3pSazOKRj6VMxGQ5MKbDDIDq8RFI6O28/dcrl1az15Xc?=
 =?us-ascii?Q?I3YCKcnkeMF+aIKBTdOPGYsNXq0KgjMP93YH/2tTqk2cZmV8xPcKWBLWGixb?=
 =?us-ascii?Q?szq8j7T5C6pXwF70bxFDYZ7Lhnpa6wOQryaAqDF3mKdRxUX8uwtDghxJSZ0G?=
 =?us-ascii?Q?43Pg1gCkDHn94+9Y2/lBBd2f5O7okMDYIZfBAzEic7L8aiS+xujbLxFosvzg?=
 =?us-ascii?Q?aGx6meg8sgnz1vInYKv5oqjgisUeOPEMxVUiubs4mNXcmDx48ZnET9fKszei?=
 =?us-ascii?Q?jDJg3nLhbqUpLdZ09UAVRFbIrl6xS3WvilH/7Ah59t75IpyrwzZuFhhVgY84?=
 =?us-ascii?Q?n/IFBJ1hwGWWMkrDY8+gi9/aetBo5JWYalZt+60MpB8phbUVe1fn/hLG/KEO?=
 =?us-ascii?Q?bxnDwPvhmuXfOlNrgQbCer12goJj0SfU6ZCJJf83ntRFHYE7adBcLHoRmyx1?=
 =?us-ascii?Q?33FI+wfHRnwoL2EX+5FQGmyNtXIJ6YBGN5kWOyt+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f4a3cd-6c0f-4e7b-ed6c-08db81c81487
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 04:34:14.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btG+/UPPJeqO3qZyHjed2cJ0RC2ciI+7nSTjZcMBTOcki4N8NdMaKvOgm1//BltnnGrZHcuahHbJsr0+9SHlzpaJya5nBTjjdPAvTqZTQIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Friday, July 7, 2023 3:47 PM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
>Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
>cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
>tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
>linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
>stable@vger.kernel.org; Souradeep Chakrabarti
><schakrabarti@microsoft.com>
>Subject: [EXTERNAL] Re: [PATCH V2 net] net: mana: Configure hwc timeout
>from hardware
>
>On Fri, Jul 07, 2023 at 02:45:28AM -0700, Souradeep Chakrabarti wrote:
>> At present hwc timeout value is a fixed value.
>> This patch sets the hwc timeout from the hardware.
>>
>> Signed-off-by: Souradeep Chakrabarti
>> <schakrabarti@linux.microsoft.com>
>> ---
>> V1 -> V2:
>> * Added return check for mana_gd_query_hwc_timeout
>> * Removed dev_err from mana_gd_query_hwc_timeout
>> ---
>>  .../net/ethernet/microsoft/mana/gdma_main.c   | 30
>++++++++++++++++++-
>>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
>>  include/net/mana/gdma.h                       | 20 ++++++++++++-
>>  include/net/mana/hw_channel.h                 |  5 ++++
>>  4 files changed, 77 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> index 8f3f78b68592..949c927c3a7e 100644
>> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> @@ -106,6 +106,27 @@ static int mana_gd_query_max_resources(struct
>pci_dev *pdev)
>>  	return 0;
>>  }
>>
>> +static int mana_gd_query_hwc_timeout(struct pci_dev *pdev, u32
>> +*timeout_val) {
>> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>> +	struct gdma_query_hwc_timeout_req req =3D {};
>> +	struct gdma_query_hwc_timeout_resp resp =3D {};
>> +	int err;
>> +
>> +	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_HWC_TIMEOUT,
>> +			     sizeof(req), sizeof(resp));
>> +	req.timeout_ms =3D *timeout_val;
>> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &res=
p);
>> +	if (err || resp.hdr.status)
>> +		return err ? err : -EPROTO;
>> +
>> +	*timeout_val =3D resp.timeout_ms;
>> +	dev_info(gc->dev, "Successfully changed the timeout value %u\n",
>> +		 *timeout_val);
>
>When the kernel works properly, it is quiet.  Please always remove your
>debugging code before submitting changes for inclusion.
>
>thanks,
>
>greg k-h
Thank you for the comments, will take care of them in the next revision.
regards,=20
Souradeep
