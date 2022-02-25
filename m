Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23284C48CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 16:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiBYP0v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 10:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiBYP0u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 10:26:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71E1DED7C;
        Fri, 25 Feb 2022 07:26:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PEkTaB013166;
        Fri, 25 Feb 2022 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xq1KFz/d2s6ddJNFYr6ecFFBNr4eI3OIg1/Km9fVKq0=;
 b=tDVpMsqE2yC3sJv2iRK5aD4VmfqGhiJEzXA/0Re0bMR3k+S8WEkj59tjGUQGeEu3FRGd
 iI+48uMQXCsA7qk4fKtrSbUCCN5qrRSw3anOsyHvYJTMKKfG1rfmnPY+LiZX9Eg2hpdz
 4XAZhK+w3fKx9sNLj40JKoexwATKJHO+/zxHtKm5uRvrCYQyIGW8k2x0kDJKHHgrht4z
 Qq4PxfASYkb9WThfxhNF9ln7Z/H8Rj6/5hJMo7fXi5ZVr1WNS3ZlW42xVMuOjSjRQZRH
 +JDOnxTaXu96iwSdXtGWWNH8qSJKSE5kMPJYxrEUKzh3ZDngt+I3ac73B0h+qP3rnRVl oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexj89840-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:24:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PFH13U069533;
        Fri, 25 Feb 2022 15:24:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3eapkmxvhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl7NZFMgIcVtetzJPTHeMjtr62l/EaRS7SnWymDf2+tL/PaZDeL3xbbhpRooaegafIvTzJjXQuvINbCSCqx8uwfMSdG/hwacKkbHUpJ3TLsOw5wUtgnYRL4Nq1EMGDr+gBdfA0LwhiDLYIoncXwypAsLKElFgiC9CLm8B1Lcrfoafs5Z5LOS2G8WgjmtN3+btPmNC0hxgVo+++NHeFAVpOO84uRTVinXLFLPMRraiTI6fQ5fjpbJp/NotapffvB8QMJTjIRKmFfAv58wgumo+jueqR71hVZRb+eXJsFG/bllreIKEv9Gi923OCq8K2bS79Pumu5dmeCa9QLzkAUw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq1KFz/d2s6ddJNFYr6ecFFBNr4eI3OIg1/Km9fVKq0=;
 b=WKTsJvlRt40sKSnZNA0aDyd3I4JOx8LeBvxKIjuHSGhBKO0EXLHE3u/Fb7kfSO5819APhzImSfcZHRBNuuBuSauCAvFRnl0SzTmVWDLz3PUpZjxLrGxV6mxc3Z5HuBs+706PG3OsMpCMUbTTe0BAoXDFIvjXlv20zej6OBO8Z9sPaw/vi83afkqCXKVXFK29qMOWzMKoxjh6vPVF9rkQAmcsXxVbu0QIs8/7NdhiZiV1LcA7anYiLDbyIAy5jtOdlCqpojaUh+8OaCeW3Gf8L5wF3LXdDmEPlp+N+aLvmJ97rVLJ9L/BrUChuyV7QdUJGLYUz2GNNwYZY4BQOgjxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq1KFz/d2s6ddJNFYr6ecFFBNr4eI3OIg1/Km9fVKq0=;
 b=oNZQ33HyaQLoiri5jTRDmHa4v3wsZ7V8T1tznmJtW3yoCK1H6Ug7mQcqKd79oK3974VG1umZ3misheKhw7qJqfmsOY8/y4hLpt7JJG0szficpJRmcjIb5OVeKJedI0cwjo71UqNNhXwuXWdXzVjlwQSZar6aNbUpzjj4P8WhkDQ=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MWHPR10MB1726.namprd10.prod.outlook.com (2603:10b6:301:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 15:24:12 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 15:24:12 +0000
Message-ID: <49710cd4-17af-7cc6-5f31-1f36afddb51c@oracle.com>
Date:   Fri, 25 Feb 2022 10:24:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: cleanup swiotlb initialization
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
References: <20220222153514.593231-1-hch@lst.de>
 <09cb4ad3-88e7-3744-b4b8-a6d745ecea9e@oracle.com>
 <20220224155854.GA30938@lst.de>
 <206ba6a3-770a-70ad-96bc-76c6380da988@oracle.com>
 <20220224163943.GA32088@lst.de>
 <8ffd8587-7eb3-d5b6-eab0-b86df5c0ebbd@oracle.com>
 <20220225084755.GA29630@lst.de>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220225084755.GA29630@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::25) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb153b5-ba21-419a-e138-08d9f872e066
X-MS-TrafficTypeDiagnostic: MWHPR10MB1726:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB172605C5A2B316A6E04A37988A3E9@MWHPR10MB1726.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRPGz6rTvBJo2Op6AviLkezM3YP/b4Wi73ZHHcYYwArqvRTtApuGAT59Pm3dpk4LBe9jN31J+T5/0j0KJKHUM9jLeU8QCzkU3ve2GQWsaHenQ7aIQNuj67guo5EL+ZKfi38mkQ2co2fQtlhXTCv2QpFfaI5XmSRK7Io09Q6i86f/tPLb65D7l58hWRxrCMPmmpqwuXVoNP+ISGQzJ7rF1a8qGb1uYi6m5O844b1XR8Hkg6RzErsi5N0jPNeZ59RL49J3Vh0kfchqH32VukKMXLXE0wtLo2zc8MYRXD5FoDT4xdmhYe6NGNWe5Ecs+0KS6CcPLBXHBHwv8dP7squ0RLNGsZlgXCfZBuHN00UUhvaasDfJY+BHPVZB5+VMDifpm4Yx2EfN/CdiuJYnZ56/OJrNrFKYJkyzHg0EQJwGOOS4oWgdM95HUpSkHBC/1OE0EQ+CicFXpkUDKXyWH127RZ8lMxg+83yBoFLgYc2rUGhb6kKBgL/nzbmRQCL+U3GMGWI8eR7jy8zAS8TFoiJAvAgQX1xUiP19Xd5+fR8sKAgVuo28VjDxqdUBR4QWt7S3UoauvAypYJnrpagbJb7QWQ51FpdfW2QdB97DqdK08YcGF3dBRPsoSwRRSEC68tXcDMlsay2OY3iMqItcPtM+6zhYpvhqZYYYpTr3f3ns2908zmmGbhOW72ZolCt/lDm7cgSEMqO4U0dFzvYQBdiyU+/WIzjhghcoESkX7XzCnQmjRTprMLNcLQQHIT/ucImS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4326008)(8676002)(31696002)(8936002)(66476007)(6916009)(66556008)(66946007)(54906003)(6486002)(4744005)(5660300002)(86362001)(6666004)(186003)(38100700002)(53546011)(3480700007)(316002)(83380400001)(6512007)(36756003)(6506007)(44832011)(7116003)(508600001)(31686004)(2616005)(7416002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dra25xSE9xU3hhNFMrclhPeEVlWTNTNkphY3JRSVpCYzZCTjAxUFRwQllO?=
 =?utf-8?B?SkFnTFBFWkpHYTd4VldHTVBvT2J1S3YraUpqaVIzWkdkMFB4bUF2WW9OMVpD?=
 =?utf-8?B?QWVHQzdkMTFQNkRuYXR5eVZUdmI4ZmtxdjZIajJpQVkvQ2hZN3VLaldsUytm?=
 =?utf-8?B?MXN3YW8zbkZiMDlPa0FXQnlEOHJsaFE2R3FZejlNVnhFK212Q3U3ZCtCTkNZ?=
 =?utf-8?B?RXFUbkZyQ0pTK1JwNXFyVkJGSmNyc1g0TWpsSGxXOXAvZU1HUHpXcjRENEFZ?=
 =?utf-8?B?bGg4YTJ6V2RuZldZQkcza2dYcDNSUG1QaTQ0bXlKTFpHQkVSUmxsUDRZaE1R?=
 =?utf-8?B?Q05TWkUzUTI0aWwxTTdaNnZTQWV2aVRjbGQwclhYSHFKeTVaVC8xbGFkei9L?=
 =?utf-8?B?UUNMam1PVVBnRmpoTGI4eVhzTnc2ZnRPWE5RZWwvdHM1K2pTVkEwWVA0TUs0?=
 =?utf-8?B?ZWpnb2QzMzJhSEpUbzRVOEtlSWt4SDB0a3ZHVDk3MnVvVVBkd2V3K2hINjRq?=
 =?utf-8?B?N0Q2THZOeUxlcVhLK3pwNTJXb21vTXNWcWRXUDN5K0JCZ0dFazJmYUVxUVd4?=
 =?utf-8?B?UXVFWnU5WFlmRzFSUE90cDliVzhXKzB1bWUrV3RHb2wwYnRDaDBCV0RoM3V2?=
 =?utf-8?B?WjF2cWhHSUhwTDkzeVJleGUyVmJRUmptL1hKU0p1TzRrRm52RTZMdEVhbkpj?=
 =?utf-8?B?dGdZaVFkaW5wcjUwUHpCM1JMQnRBTzJnU29HdmJROTRuQ0Vla203UmJlbWZy?=
 =?utf-8?B?QmNOZ1BYMTVscld3a1VmREdocnkyNmFrU2IrNjRCRFQ3NkhmRnhkRTk0MWRY?=
 =?utf-8?B?OXU3Z1dDZWVHYmd5WU9McXFsUDlXbHlZS3pBcGRDQVQxb05CMlBYblFnQjVw?=
 =?utf-8?B?eHY3TFl4a0Y0RlhGQWp0dGg2cGlKTXZEeEp3bUtYYXRwckN1U2lrd3E3d3NT?=
 =?utf-8?B?TFVZSlY2ODZrY09xc1BBUjVmWGtsV3ZaWjVWRnp5MWoza0JiWmxPUXEzaFZZ?=
 =?utf-8?B?Q1d0UGoxSFFvT1ZGQXB5QXRFSnRMNDBnYnllcDV1T3dwRjlDckRWMVc5bE9r?=
 =?utf-8?B?Q0ttTkFJSlJnUVRoZ3hQQXB0TnRIdWdzaThIdEFYVmdRRUYvZFc5MnVHU0RJ?=
 =?utf-8?B?Z0x2WGoydmw3dlgzVWt2anlrWVN5V3l6dEkvU0d2VmJITTdxMktROTFDWlhT?=
 =?utf-8?B?UU92bXdxKzVvWktGdUtDc1prdUxuVlVYTE0xa2MyU2p0NHlOVXdvV0hqVHBC?=
 =?utf-8?B?S0ZiQndHQ1QxN1FoQWg0Z1VQSFpBN0pqUTNZcGo4YStLRlpQVkJJTzI1THBt?=
 =?utf-8?B?TFlIZ0xEbjhMZG00Vi8rVmhQbXJKZVlyQzNoU3AxYWtGeGNQUzBLeEJ3S2xQ?=
 =?utf-8?B?ZjlidmJJKzRhOGFFNCs0UmdyNmdRKzhuMmFtV2VpL2wzdWN6U2QxUkhPZk8w?=
 =?utf-8?B?ZnZzKzV3L2VDNXRKeWpHZzgwc0dEdFpPekI1Vlp6SmNMWS8rZzBPS25ZYnF4?=
 =?utf-8?B?Y0RwN0o5bkkwWFNDMVQvN0s1dUNyZ3BBOHFaMW9sQTdzNHF2aWQ3KzVaMGZi?=
 =?utf-8?B?T3NUNkxRQ2pvTmZYWHlHSk9mc2V1aHNFVy9TSVAySGNrRXltQ0ZmY2h5Qzg4?=
 =?utf-8?B?MWh1VXYrUloyc3B0dVlYNXBrdDRtcE9EUHlMREp2TnpNMG13OGNEVVNaQWFV?=
 =?utf-8?B?VDVBTWlXVEJyY2VGYmM1TkprSTZnZytyVC9wYUNpWUdpd3dxcjlodGFuYkc1?=
 =?utf-8?B?dkRRRUZUVHJ5Rloyckd4b2NsY0tYWmdnM1NwWi9aS0Vyd0l0SXl5Z1pOQkNu?=
 =?utf-8?B?TDgxTmU4N3phMU12djRHN1NPa1lOR3V6NVFXZlVWdm5EaGpLSEhVMlI1NXpF?=
 =?utf-8?B?WFA4WHBVbTY2OXZzckw3VWxzTStxblJTTjczVmJycGVZV0U0VnhUZEQwWkJl?=
 =?utf-8?B?blBQcXFadE9hVDYxSm03YVJTQjFyem1ITXY0NEsweHVpUnIxR2NoVEE5cWV2?=
 =?utf-8?B?eTV1bE51T056NktwUEh6L3g3VEZZMnN1NVI0cG1uZC9haEozTitQbEV1ODhx?=
 =?utf-8?B?M2Npa3pHVVBIWlNuY1ZTbHhxeGFwSmxYeE0yUXF2cXZMN3YwbWllV3BHWWVh?=
 =?utf-8?B?YXFzQzF1cmwwUE5uYlhqd29MZStLUEozSktXa3hjT2dlVXFFL3FnMmsySFVo?=
 =?utf-8?B?djA4cGdSVWVDQUlWd2YwTXZINnN6UkZzazVGMWVxaHdlVFZyWEpSYmVadGpo?=
 =?utf-8?Q?JWDfW9GfCB9eD12jfk6yd0KOyBRrBMhIMEezy++zL8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb153b5-ba21-419a-e138-08d9f872e066
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 15:24:12.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8nwtBbhXOmqpOQiJRyAPDa9MWM8HYrPvOB5Db34UpZrEvC1bGaWNKQ6c8kJVfnmrNC8ubes8rm0q/Zkd7zRmtp1ifMsxdEnb90uc96u+/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1726
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=904 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250090
X-Proofpoint-GUID: EHKvuJik5zh0LZJL-dHJLMhDOWs_znGx
X-Proofpoint-ORIG-GUID: EHKvuJik5zh0LZJL-dHJLMhDOWs_znGx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2/25/22 3:47 AM, Christoph Hellwig wrote:
> On Thu, Feb 24, 2022 at 12:07:26PM -0500, Boris Ostrovsky wrote:
>>>> Just to be clear: this crashes only as dom0. Boots fine as baremetal.
>>> Ah.  I can gues what this might be.  On Xen the hypervisor controls the
>>> IOMMU and we should never end up initializing it in Linux, right?
>>
>> Right, we shouldn't be in that code path.
> Can you try the patch below on top of the series?
>

Yes, this makes dom0 boot fine.


(It also addresses something I wanted to mention while looking at the patches, which was to remove Xen initialization code from pci_swiotlb_detect_4gb() since it had noting to do with what the routine's name implies.)


-boris

