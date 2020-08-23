Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195D24ED21
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Aug 2020 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHWMPq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Aug 2020 08:15:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40562 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHWMPp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Aug 2020 08:15:45 -0400
Received: from [192.168.1.10] (cpe-74-75-124-136.maine.res.rr.com [74.75.124.136])
        by linux.microsoft.com (Postfix) with ESMTPSA id B0F5320B4908;
        Sun, 23 Aug 2020 05:15:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0F5320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598184944;
        bh=W6OdOYYk3KX/UrKHpyx/jL6lQ1p+oI5w9nfU0wBp9mM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h5QfkoZrEHMl3gJ1brQOQewcz31P7zjXa95lhSYqKLvRkDJqKvCISAtA9kYlvFPgu
         IAROShzcT9K1Pz4g+N4TbikFWDHLVOc+3MU6dNVeE8A9F/Etqka/IiPEfb6ULwI3Fg
         C9kjf98gi4MdA/woNR9yOpJTq5sT3vI/artemBRw=
Subject: Re: [PATCH v2] hv_utils: drain the timesync packets on
 onchannelcallback
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200821152849.99517-1-viremana@linux.microsoft.com>
 <20200822085504.ryowfhild67ktu57@liuwe-devbox-debian-v2>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <4780afef-76ab-d4c6-5d9f-8e49875419b4@linux.microsoft.com>
Date:   Sun, 23 Aug 2020 08:15:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822085504.ryowfhild67ktu57@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> Typo "packaet".
>
> No need to resend. I can fix this while committing this patch.

Thanks Wei.


