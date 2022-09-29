Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2F5EFF1A
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Sep 2022 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiI2VKK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Sep 2022 17:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiI2VKG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Sep 2022 17:10:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64AAE22D
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Sep 2022 14:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc5CSwvBQDDCQaJNC5NxdzdkvnXPFmrHZPO6FnzGe7NKgYJrNctDptKB00ajpmjNna4k2NjIxK2qwFSbox6RLAzq6RS89bVU5VR34JGk3IrKJudL/+l0l+WbsSiaWh8vRshaIgQJ/B9u3Q1UFJYEdsjYt+QXBj7tTqg4sclTX8JIHmVjkx4SDx50aHVZw8WIyfQAt2iOcnpEyey1l6i77DQ6TGNuODwcdEvGhIkPdapOztX7gN7CqZp2nqjQ4olKcumP2ywTKTiWXP3s/DF6xe0j0QRJ5TDsIvcuv3MWahkok0xVEFBdW++qqlIYTzRVCp50MkTiavs0AP7bqhduBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWuum4AFu1WDJUHM6H6TmUH7qHHzf4/1YB99pa5WJfM=;
 b=A5bYz6DjAgtwozDCVVunn3s3QckM5gEUC54t3GRq5pBNLFPFgQ0karnTxs+br2TrzO6rowuy9ltlojJ0dSX1uhfL/MgA8fECIum2lbShrMtE0CRH05v+AvLkuwPs72wjdiU0/XfQNJ+S3JaqhYT2SAczPSlRYiEWaxHHVqV/PSwQc51u4ZZHu8AReQ0Rcdh6mKOV3e++STO78Rh9Q0BZ9xRQFR1MGT36i3+1MqP7UAD+0I0N5xgJNjaMVWSM5O7/vOEpag4NThNrkTSO2MkIBuU6h9gdKLjafw9pdDXpunZG4mS8vt/oJgF1aJ3HcP+a9OW6wDf72s0V5EDLHWacjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWuum4AFu1WDJUHM6H6TmUH7qHHzf4/1YB99pa5WJfM=;
 b=SOGJTfVXiOJIVjETYJzmmaMS6nmrf0bcFzmtRRZN9yFBzf9UF6SP4zeous7M8BLLHqoltO/Lykw72Sv6UQ2Og5xxoJ/lGyLWDf9JuLicxIXNFl3cOekDS113E5u/wA9b7GiRR6xoVVVPb1HriQA94HyP4MxwB29g2vTzCi+oH2A=
Received: from DM4PR21MB3539.namprd21.prod.outlook.com (2603:10b6:8:a1::22) by
 SA0PR21MB2011.namprd21.prod.outlook.com (2603:10b6:806:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.1; Thu, 29 Sep
 2022 21:09:59 +0000
Received: from DM4PR21MB3539.namprd21.prod.outlook.com
 ([fe80::ea20:c0f7:415e:cfd2]) by DM4PR21MB3539.namprd21.prod.outlook.com
 ([fe80::ea20:c0f7:415e:cfd2%4]) with mapi id 15.20.5709.001; Thu, 29 Sep 2022
 21:09:59 +0000
From:   Stephen Hemminger <sthemmin@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Gaurav Kohli <gauravkohli@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Thread-Topic: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Thread-Index: AQHY00EEonDO2Eqw9UenXeZDD8gM3K324LIAgAAIDpA=
Date:   Thu, 29 Sep 2022 21:09:59 +0000
Message-ID: <DM4PR21MB3539D38A74B62AFD95989581CC579@DM4PR21MB3539.namprd21.prod.outlook.com>
References: <1664372913-26140-1-git-send-email-gauravkohli@linux.microsoft.com>
 <BL1PR21MB3113EF290DA5CE84A350D6BDCA579@BL1PR21MB3113.namprd21.prod.outlook.com>
In-Reply-To: <BL1PR21MB3113EF290DA5CE84A350D6BDCA579@BL1PR21MB3113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1ac951a9-e996-447e-b217-58dd1163c49e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-29T20:35:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3539:EE_|SA0PR21MB2011:EE_
x-ms-office365-filtering-correlation-id: 865d4fac-0038-4939-6f38-08daa25ef7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfhhfGqeoXgDJ6j1EqOmCWby0EBsTF8gavwu5Ic9KrJMUUI6hSBzaPWn79bl8Mpg+QopEgycpjXCpoqVZMzwrrXyKbn1++skYEXw4Nwh8veutbD28+jPDun13r6X2gwED74LUu1sjCja5m07TAiXdWnC2LFfJsiBlDR+ZSH1zsBSfCdrQJCSjt43PfSIxz543CVIasa2N/LnhvqM5gwHQFlQLEivlq9aSr2vPQovte9+Vqs5YxYuDsP8Oct+towmIQrSMOwSn7Cqh87neOgq829wCkV+WSJJEOv4Dhakakur4/6jC0OOGlrbiZ2ILE2ixihxns/vOFFqpMUniLxQue0gqO5LqPSpG1WTCbawBcR8iU41G44kLp9W7yeFZ5aEfaCm9t+J4nq7R9CUcXnx+8XeJp5M64r3kfEbtONwhvft9XwBR7RG+t75rE1RuFyPcWYeFoWAwckDvivgp167BA0EQX539n5bKUasKoeQV3/qm/grK8LDyU677+f7Wqxd8JEuWqW94tGNH/r6qePo7TiR0XfAkP6xwfI+VO0CdPBjcZ6J4owcubGDBJbePfn2zMYtW9J5DCA6KYNYmfFS4eG7xjJRuKNBjiH3GItsN/6r6alVL62Hsgfedy6ICVOHwpAMKVnbfcE6F4lAfQTfGaI/fUy4JCkrMY3H8wvojTZX8hbgP9Lj3JU263duDc4CtPtwLdEnciKCZ6bCsIB9AdzgT21dM1cuB+RMihrWei2khPMs+Mpl4Wa/5Rf3NmXkZikoc/oxcdFVZw1qWZO4nUsXm+unXlFnwdHhUV1D8lzRWGkRFN5nwBzXTzxLL7eV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3539.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(26005)(7696005)(6506007)(9686003)(478600001)(53546011)(71200400001)(83380400001)(2906002)(186003)(15650500001)(8936002)(52536014)(8990500004)(55016003)(66946007)(110136005)(66446008)(316002)(66476007)(10290500003)(8676002)(41300700001)(76116006)(64756008)(66556008)(5660300002)(66899015)(86362001)(82960400001)(82950400001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I11wZvBf4NwwrJV7vgOfwMQB9kZbWegbrWTWYvhx2epotuEb4MQFHNwUR833?=
 =?us-ascii?Q?l+ytlhDSIlUECI4B3dUPvRMuWFyglLTICsod1g0dM7cPkMLh2ciQO6wtZ3Yu?=
 =?us-ascii?Q?AzjV/GkJ/SvaltvE9uXDSKJGY6bxsnB4sUYJzvwzyu0k07mrqFeMJ3fpr8Bw?=
 =?us-ascii?Q?8FPkjeFBwlcVwq6RrGnSrBir7vbxecKFoy2V440eLDdzpFJMSEosicAjsXKr?=
 =?us-ascii?Q?50QvKsl85P/oEUTKkfdRRVPcA+DV0CIiOvEyP8k1BkPW4BHjYe7fQb5+C0q9?=
 =?us-ascii?Q?5k2ZYBsJw7Wy+GbL2Z9OQtnVNatAOud6M7qwrYPkfAvYL9H8CDdBCJMNfJN1?=
 =?us-ascii?Q?d973ZarNPUWC2iDGX41+buxL7XnRHqv3ptfDsEcOoe2QqU25Z9JEpvbfQOpo?=
 =?us-ascii?Q?a4Z75OA2eoXQ6GBRkJbLDy5bkviyFyeKPPB9RYhXMctCC7y/Zm4XMJUST5qI?=
 =?us-ascii?Q?kU3AoWhUo5U4Qgob+PvC9Wste+Q8b6DjsfwCf0jVUywbCIksxo0JPQya/Qoi?=
 =?us-ascii?Q?eyZlfqOGu3P/6Uk+AO8C2+HirxEQfQOZIec//7oFvJJCDEtQQkMuBI8dteLS?=
 =?us-ascii?Q?ZMCPQPDM+UcDd5wa0BjXnCVfiMUJIO2wRNqdwWSCaNKGSocCUx9tM5G4cExE?=
 =?us-ascii?Q?2j3loQflN2+8Kj2/VKEvi4oze1FvvXHpEOELAO2TPOeIguS//bYdsNWMgotM?=
 =?us-ascii?Q?6YWxNrmiAdJXkOTRd21PjiEJZ3PQs1UDVR/GJ+nzDphaHcCzmCiMtmfnSxWO?=
 =?us-ascii?Q?GgkJFF3bulIAMVzLf6qwHDPXjse4YGKRcSja2TSY69y/6mtx3E0uHTHCHvyu?=
 =?us-ascii?Q?tlIbdYowM82VDSmOfgUl8xdUrGqa24pjj6zAoSDZsYECENS3jTKurltiQMyd?=
 =?us-ascii?Q?TfltxgslmLBlavz3fnAaJIg7XuOD+JXXBqNAq02LVr/9csDyppz6sO1MFAav?=
 =?us-ascii?Q?76IN3IDRo3VgFvq7ET0QftNM1J8pcmw876PoYM0bGJnjikVfXDMaduxvOP/2?=
 =?us-ascii?Q?3tIgsxS9ZZZRdkQ6NnVpr208jWCtzWpSZegngcKBbPXBetFejgonV5WHfx4F?=
 =?us-ascii?Q?OALETWfNw9z4qQtv1+ChskEcEWwfeGl8bRpooO5i5uUqtoVnPW3PC9IPCEkp?=
 =?us-ascii?Q?xtYuleL8LLnHd/86MSTGsrzztzD0xNtqSgslotqYghXPmQBOUjjQCLk4Apc4?=
 =?us-ascii?Q?LsLMH3ITY3LIyeYemLx51zUh/cfT37/s9RzTumMCLBBPnB4O3ucL/+nCTk2K?=
 =?us-ascii?Q?0uLez1wnvsMuVZPj4beGh0fhXNR4PRkoiwwk3obR6v1gkqruyuO7zGomBIqQ?=
 =?us-ascii?Q?L1sjVOSf8GvZJhoUY6EQpt9YqYtNAJIV2nb+VCIhsz5eO1jKPCrmIRSULq6B?=
 =?us-ascii?Q?isP8C6CWzD9oo7ZGKJdha1SUye+EYXA616fCEKVMlJs/AHVGUT6mxh7Dr3RJ?=
 =?us-ascii?Q?jP9p2wOIUCn9MH85wxCiSxCI00InzlHiSUXUsX/mI5g2793YHnv7QTUKAKjP?=
 =?us-ascii?Q?CuUUkvq8RiRwRZAHkaxXL49j+Zbzz/Fk+OmtBaggJYbeQYRQfRRTb4zbfZb7?=
 =?us-ascii?Q?/lq5IgqXk1/XARbhL/EKgAjzYET7eWhr6wNf2ABk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3539.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865d4fac-0038-4939-6f38-08daa25ef7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 21:09:59.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sepJdO9Xq7YtutABzDYKmC1Bpuez/68qsTMBhv9IX7zbxXPXJnaH2DQ186v+X7FfF8EapAjB9cqSBTOwrWltfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2011
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The policy of network development is to not copy the stable list. Instead t=
he netdev maintainers want to curate the patches going to stable.

-----Original Message-----
From: Haiyang Zhang <haiyangz@microsoft.com>=20
Sent: Thursday, September 29, 2022 1:40 PM
To: Gaurav Kohli <gauravkohli@linux.microsoft.com>; KY Srinivasan <kys@micr=
osoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org;=
 Dexuan Cui <decui@microsoft.com>; linux-hyperv@vger.kernel.org; netdev@vge=
r.kernel.org
Cc: stable@vger.kernel.org
Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF ass=
ociation message from host



> -----Original Message-----
> From: Gaurav Kohli <gauravkohli@linux.microsoft.com>
> Sent: Wednesday, September 28, 2022 9:49 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [PATCH net] hv_netvsc: Fix race between VF offering and VF
> association message from host
>=20
> During vm boot, there might be possibility that vf registration
> call comes before the vf association from host to vm.
>=20
> And this might break netvsc vf path, To prevent the same block
> vf registration until vf bind message comes from host.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 00d7ddba11436 ("hv_netvsc: pair VF based on serial number")
> Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

By the way, did you use "git send-email"? I didn't see the stable@vger.kern=
el.org cc-ed in your original email.


