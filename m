Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49C44BA847
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Feb 2022 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiBQSbY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Feb 2022 13:31:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiBQSbW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Feb 2022 13:31:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B538A8;
        Thu, 17 Feb 2022 10:31:03 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HHSswJ002481;
        Thu, 17 Feb 2022 18:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qE+/gsEjk5peh+SceGaOUJnjfverr55KEpVB1gvyb1o=;
 b=jQt5g6cX82+8hdZwHLCRCqWI4lYh0fYZS3R06In1K6FXUmO4KZ7c3Vk+GHJ8bLzwfnZH
 UDBKIgBScGUbl0RebDjCL5Y8LXRj6S+l4t6sfvNo2Ij46rP9/QjKQLbz4SoZKeVAdnEO
 CaNxo2hDtyiDWYS2QfiIEoXtw/g0v3KKk+yOzOV4S5uV/Tiw0CiRV435dW5evOGY+XXI
 yiYBUNAeNLQzn6dUDwTthGDswjyM360yZDNOZ4IBs0MUm7ejVH8R4uAVCP3VhjYuM8VW
 lYW7EW/bpaG+aewCbkNq0OUHiPv3xLo8jrOHHkOQLFEzVszcebz+xWgZuiYp2ZS9qqbq TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3dxxw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 18:30:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HIUa6C018311;
        Thu, 17 Feb 2022 18:30:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3020.oracle.com with ESMTP id 3e8n4wd6qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 18:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcfB9RU3TU0JK6TVT3PXEvjIQmSIAa6Va1wXHH5a2nmLuAVVF30Q8BQMb87liPXnQVCPLE4hlmjZsWqYSv71JPIg+1IqGn+a993rF6pAZiQA/xxOIXmgml0KxqF2qjY/kPX6BZXPaeBh8WXl4tHs2saZLqnywbuAPG2SzHI8ckk1qbl7Wx5rJ2yBkl6QP/h/7q9RCjOhBOC8DuxgtQgannaW6ouhi0d3fzg8+5LT1nYdF/90JvySLCXa2gvrsDl7ARUKnRPnptwWekWni4oK9ICKk7BZPv4ZF3cUzZV5QCN1gtX/uWlSFD4WLguAJgFyPgFyddTHd6fA7JgaldOPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE+/gsEjk5peh+SceGaOUJnjfverr55KEpVB1gvyb1o=;
 b=Mj5G0xPYJ7gFrFM3EQI7auU1YgX+jIgPZ7mq14PTOPoPvhO44RWbiTSQYvhlobuqX1dulYetiRnQkxgtRGRP6qfjPZTYw8Q3tV+ijcyF+3SQgUFSZy7BHYtZryicBgwnx7CDFxKpYQ0FhgvTW3kRigAbHLfwrieFF/99C30/RXrntLKyXgNAjwEMLGvoueQA4Cu/LzmM+3HqMl3hg5aVQs9v/lgXYxCBXg2si/P9e6m6Xhb4Z8Zgk2isMtOq0PI0eIUGGqTRaFRXb/sdDixgSqrY2ELPtc9EkJ7P2ET//PqV+nU6DXkdUMl39TiLK+w2jixowM7aPWi8Adzvz95+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE+/gsEjk5peh+SceGaOUJnjfverr55KEpVB1gvyb1o=;
 b=hdjbtjNu1VXfhoE7uj1qf0UVWK0mFLfcKR5c4QRae2dTzcEg0RX3ExpjcKo35uUQMaIDHkmKfEGzq4SOjeXeh/GaTkDOuWto0Ev5GsD/yA0awviAuKxM7sCDsihIOS4JvrMPAtR/ypBovmWlhxWK26t4Kq5YJcMChC37pCzAxSY=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BYAPR10MB3094.namprd10.prod.outlook.com (2603:10b6:a03:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 18:30:55 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6946:88ce:631b:3782]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6946:88ce:631b:3782%3]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 18:30:54 +0000
Message-ID: <299d3db8-a473-4685-7788-385a8d73b26d@oracle.com>
Date:   Thu, 17 Feb 2022 10:30:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drivers: hv: log when enabling crash_kexec_post_notifiers
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220215013735.358327-1-stephen.s.brennan@oracle.com>
 <MWHPR21MB1593EAD0167AA9EC4139042AD7369@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <MWHPR21MB1593EAD0167AA9EC4139042AD7369@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8f108c-d3ad-4a07-b5ad-08d9f243a225
X-MS-TrafficTypeDiagnostic: BYAPR10MB3094:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3094EAAF66503F01013F06B0DB369@BYAPR10MB3094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWPSabhWfziqeCoTnc145ncaUeVPjZiwD5+YBUkO7wfS9e4bjMl3nEyIpAe7p1nO7lMuuHZzWqxjwPhNF6IN8RDy448bceSZnIS1N2NCbgq55LCUxii/Cp+5CIxPjyGltaQrFv4Ysjhg1lWVkYlxgSq0oQ1BJJe9P32FtfJhIDUchZ/bpW0b5O3q028Yt0uIS/uDS6dIFDUtUcZPGUVGgMlh3XC+pONf3NgPbwq68Ph9dwu8+LZbShzuWoPpTe0Nb4Wff8OkbULqf892eq6F7gSFD4vbC89tnJuooKj/Fy1QRAqeauQA/hkxbPt57CJJzvabf5YWXglDR2UZf0URE1CsmRQcmwD0yvFr3VYV53Peo3VYF1LxeEipYGdvm9SN6qM4Sdj6I0d/kkUP7dQ1Hvl42AvEC+vn7ajKZ2VxtTcwbGtMEPnIqb857MdnLW8gra1+vctMLPBb72bXXtSR1RpP4ImTnlIwjVpgvlMvbnF29wCRdODvDZqjGZXPBbwf1asxv0iyRBVLzJunm4c/PN+gh/O+kpbFO/uIxNnzYZQ60hbhHOqJp36Uz+sloQbG/MIiyQbk7fEltsdYGABc1k5gcCphP5kOwr69VMFr5iP8h4vbbf+Lng/IoGsyhGR/0dbQaPt/s28amWlvtfHLpa0DTx6gLjajDCuwLAv9X+Ew7A0nxuMSx9e6kVE7vJlEd31wsM7Ar/Jllj9j9MD0+CJFAZWBpiqXb44WayJ1fkQCVbxyoIoEPxa4uCHYn4Zon/mLUC0x1FgdIQEezcC2zDVvoOqzOmUUqwqWGWjv4DV1+LAOEwFUtomkmW+c9uGZ2X3rwLQbbBjBQ8OYeoFn/YWdYQsJqsB4pcxpegrHK90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(26005)(5660300002)(53546011)(316002)(45080400002)(8936002)(6512007)(6666004)(36756003)(6506007)(966005)(2616005)(186003)(31686004)(38100700002)(66476007)(66556008)(31696002)(86362001)(6486002)(54906003)(8676002)(4326008)(2906002)(66946007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZmeXFiSkpuRVVISkNBajZNSkREbFYvQ2FVTnJSOUlKZFBqM1VkMi9ieFJ2?=
 =?utf-8?B?bThBVnpVMWR6d1pvNnlaeVYvTEpQdUxvUXVSV0NKNXRmekRXSElpL3VaK01G?=
 =?utf-8?B?YUNPOWJMbExrSHRSWkREWjFXYmxFaXhROVVIa2Q4dHdaMUw3d2d5RDNsaG81?=
 =?utf-8?B?RGh3STR3emV2c1FaYm5ORXUyVkVEUFNZRm5yczI1VEVBTHZSWFYrNGhVeUQz?=
 =?utf-8?B?bWNYOFlwSlRjK1hQS0YyVG5iWWc2L3h2T0hJcnZXT2FZZEt4ZXBnQkQ0Zjd4?=
 =?utf-8?B?cy94L21HWlV6eWFpYzh3ODhRRy9TVVVXSExodjJnR2JCd1RBVXlxeXlvZk9O?=
 =?utf-8?B?T2hlby85ZnZQV3crUDZMK3JrU3VWU2FuQmM0U21QSkgrcVlTZW9NQ0pKM0VD?=
 =?utf-8?B?bUc5YzVYaGN3T0tEZDRBbGdtODNtaHY1RmJvcjYrL2VZSTBsa25ZRjlkRGdG?=
 =?utf-8?B?RHpNK1E1bUxtVFBIL0lzakJKajM5RE1SNHhCV2ROVS9hMGcwS0ppVnd2R3Yv?=
 =?utf-8?B?UTAvTkg0dkl5UG1XOTJjYW1OdTgzZHlOZTdOeGl1OFZPZE9sOXgwR3FxKzlC?=
 =?utf-8?B?YlVlT1BBdFljQkw0N0ZNQkNCdUd5WDBDK1JpL2FtbEdKRnhtOURwSlBKM21Y?=
 =?utf-8?B?Rnl6MFZqT1ZheDJzc2RqR1lLS05FTUJIeVFUS2JaTWJFaUFSWGQ5dk94L1lJ?=
 =?utf-8?B?ZUwybWtHSVlyTWt3UzQ0ZnBmWFk1V3VYenQyZ0hlUlkya1d3TVRZWXZQZTFZ?=
 =?utf-8?B?OWFhZVdieHVYejErVlg3a2xUMzF4WU1DNWNaM0lwN25DWVlWYW1GNVFxTjk2?=
 =?utf-8?B?OVpWNHVaTHQ2TnpLWkc4VUV4c2R6SUZYSTUrTDRIMWVuQTZJdFFYeEdJZDUr?=
 =?utf-8?B?V2QrN2JhWlJXTEhXR045aC9HN1JuZDZLbzNYZ1B1bkh0cTNtd0JmUnZlN1hD?=
 =?utf-8?B?c2ZoTWlaL0prUVQ1YUVLR216YTNFb2pKTDZuNVRQeWdTQ25aWGRuSlBBUXR1?=
 =?utf-8?B?ZGJvVG5HZkZQS21EYVJ2cmJRbDZGU09nVGNyeldtMWh3QVlVeWpWVlBrc1lw?=
 =?utf-8?B?SUkvQmUzMUFKSjlpZjhVZHpBbkpsZTVKV2FHZ2RYc3hlcTJKSlQxWENlVzdF?=
 =?utf-8?B?TDAxK2tKbC9YdFVJY0l6TFA2eFJhQnRwWHJsMUgxVXVSZ3hQYnJnMFowSkcy?=
 =?utf-8?B?WTNXNHJydXNqZHA1akxlT1VoSXJLUTJ6dy9pbmt1TDlySDhSVnVMUm5KbHNL?=
 =?utf-8?B?UUo2RWdtM2ZEWUdMT1Z3NDM0RUZqTGdYSS90blBac0kwK3BYYzhlbjE3V2pK?=
 =?utf-8?B?MTF6SmMwVVYyTG9wOGlrNHYxRTFCczZTMWNYWWU4QVVhZzE4aU4vN29yNUdQ?=
 =?utf-8?B?TFNBL2wyMnYzUERTNUVGN1BpUjJhNWhsTExlNzNGbEVtTExJQnl3M3Btdm1w?=
 =?utf-8?B?bmtmRndvbEtuQk5FVWRtUlNqSmxvUXlLNjBOWXVyTDRKcHNqNTh2RXJoSzd1?=
 =?utf-8?B?T2o2ankvQm5Ib2NTbmpJRnA4ek5mbi8vcFhlZnNLUGVJSkJyeCtua2tUMTFZ?=
 =?utf-8?B?SGwwWnNZc3FCWndIaE1ZaHY2M2NLVkVPOEVUUjE2L0NBQUFjNGUvMUJEVzNR?=
 =?utf-8?B?dldISlR1L2hhNjl0b3BRNnJ3aGtZU1JxWVNKVjVjMXE3VWY3eFRGUlpGYnpV?=
 =?utf-8?B?ekxIZjJDcHVtVGdCQmJuMmNMWUFZK1BMYWRZZEVRVG0rNzBjSlVVZjMvYWVQ?=
 =?utf-8?B?a2dtdk5VSG1GL2xQQk1YK0dSQ2tNVE9ZZmR0YTNRc1B2ZlRkem5GbTdXamtZ?=
 =?utf-8?B?UncxaXhnN1RUVEIxeG4xMExmOHNjREJKWXBIZ1k2SC9OU3NaOVkvSEhyU2dm?=
 =?utf-8?B?ZThnblRraEkwcDN6UXRlb2VuMUxsMnJDUWZYZXNacVkrY213cGNyZWtjbUxL?=
 =?utf-8?B?STViUUIxV0l0K25Jd05TcERZYzFPZ3k1ZWVFZ2h6N2lFTzdWMjdxYVFnbTJ6?=
 =?utf-8?B?Q3pzOUVmMDg4Rnd1OWJqVGpaYkpjSlF1L0hneHJZeGpTbjdLTVo0cWpONmdW?=
 =?utf-8?B?R1lwNlY1R1dYMFQvRGgrdmdIcGNXWUV2enNrdVIyL2tLL094T0RVQVhFT2RK?=
 =?utf-8?B?VzBJanFjSHhRcGdPSnlvVlQ2NWhsaHhoZ3JxVi90b2ZJUmtPcGVRMnJVcUdn?=
 =?utf-8?B?Qm9UaDRhUUlMbkhva2JvN3dmcEJzcjBVZFpkOVpyRVAveHRpSnlMOWJsQ0Ro?=
 =?utf-8?B?VTRaVkpmYlZiMTAvdzFmV08zMi9RPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8f108c-d3ad-4a07-b5ad-08d9f243a225
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 18:30:54.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bIzfdq6EhNWTIB8IO9VZPWJxLqJhldSAg7w0VyVdBi3x6u1pfab6vwNSOn1r001Tr4ezHIdhGILeTdNnWCfFMAhvacru9gZVPl0jjMimrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170085
X-Proofpoint-ORIG-GUID: gr3uLoUUFb1XFvPYjX9cCLoCQmk-cEG4
X-Proofpoint-GUID: gr3uLoUUFb1XFvPYjX9cCLoCQmk-cEG4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/17/22 08:44, Michael Kelley (LINUX) wrote:
> From: Stephen Brennan <stephen.s.brennan@oracle.com> Sent: Monday, February 14, 2022 5:38 PM
>>
>> Recently I went down a rabbit hole looking at a race condition in
>> panic() on a Hyper-V guest. I assumed, since it was missing from the
>> command line, that crash_kexec_post_notifiers was disabled. Only after
>> a rather long reproduction and analysis process did I learn that Hyper-V
>> actually enables this setting unconditionally.
>>
>> Users and debuggers alike would like to know when these things happen. I
>> think it would be good to print a message to the kernel log when this
>> happens, so that a grep for "crash_kexec_post_notifiers" shows relevant
>> results.
> 
> I'm OK with adding this output line.  However, you have probably
> seen the two other LKML threads [1] and [2] about reorganizing the
> panic notifiers to clearly distinguish between notifiers that always run
> vs. those controlled by "crash_kexec_post_notifiers". 

Yeah, I fired this off before seeing those patches. I need to get on top 
of the "lore+lei" combination so I can see these discussions quickly, as 
there's no subsystem-specific mailing list for the panic/printk stuff. 
The patches only surface if you're mentioned or if you trawl through 
LKML itself :)

> If the changes
> proposed in those threads are submitted and accepted, it is likely that
> the kernel log message in this patch would become unnecessary.
> But since we don't know when those proposed changes might come
> to fruition, adding the message for now makes sense.
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thank you!
Stephen

> 
> [1] https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli@igalia.com/
> [2] https://lore.kernel.org/lkml/20220114183046.428796-1-gpiccoli@igalia.com/
> 
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>   drivers/hv/hv_common.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 181d16bbf49d..c1dd21d0d7ef 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -79,8 +79,10 @@ int __init hv_common_init(void)
>>   	 * calling crash enlightment interface before running kdump
>>   	 * kernel.
>>   	 */
>> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>>   		crash_kexec_post_notifiers = true;
>> +		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
>> +	}
>>
>>   	/*
>>   	 * Allocate the per-CPU state for the hypercall input arg.
>> --
>> 2.30.2
> 
