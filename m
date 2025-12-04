Return-Path: <linux-hyperv+bounces-7964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A21CA50B9
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 20:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B27319096A
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Dec 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4D333434;
	Thu,  4 Dec 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TkQ/QFYV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C72F7AAC;
	Thu,  4 Dec 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874661; cv=none; b=CzkcofJKSIhE5cLtcVJE/Mv1Q8Rz3aRMU0b3lOV1ruYCZEif2whwzTGOMRbx3hH0rgXMGmsbwYs5AYk0ZACvYKr5XupE2suHtrnELlLapJqNkjRAvCIhvK9+kCeAul9Kk43N0X/1v54nCmwmorJn7TjzPCFYBlyG024q31umH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874661; c=relaxed/simple;
	bh=yGoBUytSxr/54b9xaZHWRZVupI1wr61nAGA5NH5Dz/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkEBvfWQR5lQidX0ALvwOHCxKY9mfaQwy+Bhqu/Pj80GufA6iXggqq5Ew24juY2v2lEqBNM+VzabEaVBKrezMoKE/Uq9agdI9RDdzkpI81gOK2H8zEQXpp0abbYVBGQ/oIRqpNeAjqpGpwIsP4qLq16IT+YeLI6TuNhOLNLBuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TkQ/QFYV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.225.25] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 38D85200DFDD;
	Thu,  4 Dec 2025 10:57:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38D85200DFDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764874652;
	bh=TWlxzFshZZTuuV63f8KDee7t08ZRkbvSn8N8uxf754Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TkQ/QFYVd8i2jid08IpKCnzGZSteWN+Ax/MWgsRT9B75jmaAQyVmghSYLyK1xHh/7
	 4WdJloYvPGpqeyUTf6F+U938acOrq6OKPDy/CuycB9RDEB2nAEoqRAmUa0/ucC4vkk
	 Eg4YV5Zze0DzyHgIc5WWej7+94jijBTug7ZC+vEc=
Message-ID: <6704d1d1-9968-451a-8771-f4754b9a2126@linux.microsoft.com>
Date: Thu, 4 Dec 2025 10:57:31 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mshv: Add debugfs to view hypervisor statistics
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
 prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
 paekkaladevi@linux.microsoft.com, Jinank Jain <jinankjain@microsoft.com>
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764784405-4484-4-git-send-email-nunodasneves@linux.microsoft.com>
 <aTCNoecOOFHabyZC@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aTCNoecOOFHabyZC@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 11:21 AM, Stanislav Kinsburskii wrote:
> On Wed, Dec 03, 2025 at 09:53:25AM -0800, Nuno Das Neves wrote:
>> Introduce a debugfs interface to expose root and child partition stats
>> when running with mshv_root.
>>
> 
> <snip>
>> +static void mshv_debugfs_parent_partition_remove(void)
> 
> nit: it makes sense to add __exit to this method.
> 
> <snip>
> 
>> +
>> +void mshv_debugfs_exit(void)
> 
> Ditto.

It looks like __exit is purposely omitted here, because
mshv_debugfs_exit() is called in the error cleanup path of
mshv_parent_partition_init().

Thanks
Nuno

> 
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Thanks,
> Stanislav


