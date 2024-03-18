Return-Path: <linux-hyperv+bounces-1768-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16687E2E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 05:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D1D281F0F
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 04:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1820334;
	Mon, 18 Mar 2024 04:59:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33403214;
	Mon, 18 Mar 2024 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737965; cv=none; b=fPBiIRqgx1lf7tQepgpTyaKjOuEZBT/46dEKpZwqA53+NGUFowKzpehQ2ZMoPdOUgnZ9IqmOF6gyq0Et2gSZlEZtxu22C6tkMbYwWafc/q/BUZZGnjGgasgEcl77GV/IdyS81dybtN580UJ3UO7zjICB0VUP/ekoPX1lEW2pznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737965; c=relaxed/simple;
	bh=/GQ90lmdOnnjH/kpX28xXhau4c1hBY8zpO3zMbUxEgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq5apFPSwkTIBqpIxlmC745/5mUtuei1zl8EnRuM5ALn2G1kYq492uRmueC3BdtOiSW8KEX/i8v+R1AeMHRvo6Wp6djx89wUDXHxwn6Eu936g6jJOtXrcfzJAlrXPBcy2eobeOZS5yYLcWE8wQnD2amegQDroRSsPmQpjAdSrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dff837d674so8173765ad.3;
        Sun, 17 Mar 2024 21:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710737963; x=1711342763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK86KpxK8CzyD5BH46M10b5ppvmVT5I50f+3K+eD3jU=;
        b=YaiENJEe0m2HBidPNkc83qr6rC4CPhelnpLYltCIfSlEy49EKEFxO04KuFPg1BxibW
         9PIF3EIP7LyPnylR4erFYyuAUuJa5RISmatd8Ta4/+tztdJpMqCpmgsULLehcwlduzKQ
         e2amAi1bWT4flXn0of+7VoOVMts+yFJXQJBB6Tj10KdzVFV4ORGxcIrNFexmh5qJ61Un
         yVT1C20b8dZQZVUoF+/I6YFTpbINzBGYgRi3b6fofO4xUNlGEM1RmBM05xyGF2t2v04/
         CfR+Os/moOi+nE1ycn4wcz3r3+caYOaJ7jENxmaPIepGO36rF8FOvCbPGIlkz2TubPS1
         2mLg==
X-Forwarded-Encrypted: i=1; AJvYcCVq/gEQFMoe1K2uGBQ858NbFpbOr6PgxsVISCdxFOOhV++qg+0ob59dn7B7FW511biVDoxldTXZtGMoepVeFSDzOW6y2D19OHjsL6mh
X-Gm-Message-State: AOJu0YxCorLdQcCD0VOIIeu5ExCjiIhxuqIEPXN7orl2Td687L0A5zQO
	otwFDckEXjDBV70JhLF1nm/ZZus1AX04g4/+MGf22S1ZBlXo2jmI
X-Google-Smtp-Source: AGHT+IGFGF4iVtql51zNVq6J7Z+W42IBV1OCcVn/8kSo19elV5BVVP0cN1bzcpA3J+aUhSu1qXaqng==
X-Received: by 2002:a17:902:be15:b0:1dd:81a3:8dc3 with SMTP id r21-20020a170902be1500b001dd81a38dc3mr10261280pls.46.1710737962982;
        Sun, 17 Mar 2024 21:59:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001db5ecd115bsm6693454plh.276.2024.03.17.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 21:59:22 -0700 (PDT)
Date: Mon, 18 Mar 2024 04:59:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	haiyangz@microsoft.com, mhklinux@outlook.com, mhkelley58@gmail.com,
	kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, tglx@linutronix.de,
	daniel.lezcano@linaro.org, arnd@arndb.de
Subject: Re: [PATCH] hyperv-tlfs: Rename some HV_REGISTER_* defines for
 consistency
Message-ID: <ZffKJFHFmYRywBHe@liuwe-devbox-debian-v2>
References: <1710285687-9160-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710285687-9160-1-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Mar 12, 2024 at 04:21:27PM -0700, Nuno Das Neves wrote:
> Rename HV_REGISTER_GUEST_OSID to HV_REGISTER_GUEST_OS_ID. This matches
> the existing HV_X64_MSR_GUEST_OS_ID.
> 
> Rename HV_REGISTER_CRASH_* to HV_REGISTER_GUEST_CRASH_*. Including
> GUEST_ is consistent with other #defines such as
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE. The new names also match the TLFS
> document more accurately, i.e. HvRegisterGuestCrash*.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-next. Thanks.

