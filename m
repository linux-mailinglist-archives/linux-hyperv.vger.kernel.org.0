Return-Path: <linux-hyperv+bounces-7020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6CCBAC0A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79632178814
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E082F3C16;
	Tue, 30 Sep 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxxvQrOT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345F2EC0A5
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Sep 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220845; cv=none; b=OQ6ppcTfXYey6thMeQ6w62pfBzMDfBC3g7f1rRvH40M+BqwmEwxQlyI8gpspk6uNBRl9XJPin8gVO50pWdDKTU0rLJO0O22VRxNcoe/SrfSc0dB73zEx2HmRlie2pgSlBboLL8zXe82wjdqabZICJCpjZkz8jRGvj/q9jtulIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220845; c=relaxed/simple;
	bh=OByUwkUqD2B2/nwZYmEaHE1jBaKbSJmFUJdyN/riHtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9/kig/MhM/D7lcuzerlqnboSQxN5DiAeEBiE35zFL1XoGTlykapDEdtax/jdarDr25Eiio2UGE8gsOi4MkYaXRVM/3BiS4wOit/UnFXcRVs4Mz5QhT3ti0HxaK9VN8Liwe4Ag1bgUPI9AQcD6qmzyXtKUNPNlt7MlXpSCJ5kYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxxvQrOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759220843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k53564HVWSnWT4QeushBTs4QSP6pO7lgGYw2Y1kNtA=;
	b=MxxvQrOTEJd4IkkZlp9KIQkz4IW5/cuKKVtpeieRtCTuEYSN+S2VA9ctYX7ZHndM913x2l
	9RAHbRjPsThoi7wP4rOSibZ9WAEyxVzlUvHn7w7GhevuwLoiSZDM5RoqZDGSTLLiwmjhAu
	n0DArf36srIUOLNVFswlRA5EWhNXtj0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-DJkY6Oi2NwqgNbjFfZ2V0w-1; Tue, 30 Sep 2025 04:27:08 -0400
X-MC-Unique: DJkY6Oi2NwqgNbjFfZ2V0w-1
X-Mimecast-MFC-AGG-ID: DJkY6Oi2NwqgNbjFfZ2V0w_1759220827
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3af78819so20395465e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Sep 2025 01:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220827; x=1759825627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k53564HVWSnWT4QeushBTs4QSP6pO7lgGYw2Y1kNtA=;
        b=LK7gECXhzNa2NkZp+wuS+7Rd6lIjm5HKaNB4oEpAs4psKD7b4oJTgvTbSmNK8YodKs
         2PkdMr9GbvLxuB9RThAiJRaM+A6uU5FX/zp4vdnyFqlZMhZU8LPbbA14Y/pE+h6IyKJg
         +rlU74aF1888xc5YM4cswM0t74MXfPhHm6EwtIYUdaPbuAjBeNfvvmOumfAFzryLK5mU
         wgA3aFRuz9geMd4Hb7RNz7w+XOp1CViRytcQMbX7/Q0K3pOcmAQxwbksKBO9z8KBZo2V
         KwGoPFKyHqqTBPPWOv0eXqCxxe834qLnfevzhRwZmG3X+aRKHhWIqPCIceMF4r6h45JI
         ENuw==
X-Forwarded-Encrypted: i=1; AJvYcCWrvYoSvtqpl2fMpkvJks851phLSPW1Ae0AN3C7rU6/pxTQBDAd3HibtJzzLUIrAjzTlM5q3oP8mQ/XeWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdiQdLvqCtXHSrGsdPubz8rvfiqD1AkrKkU06jr+LbH6q/GsX
	n7ZjxzNLlzq8Ga9PW2jdi/4TqlxPw6qfV2fOy5bupaCSG2gtAEegNULarHxHDlPwlgBC6GjCidq
	O2flcQy6svZO7nY+e4HxgqmuyCrZc2HhvZ7JfjZoiNnNfpvETPVuN7LCZrHAzn9XAHQ==
X-Gm-Gg: ASbGncvVG4626UopY6/cMheJcdaOZzxJU3WDTsdqOn2MsEtn4Gnv75q//F0xh57oA/9
	zJ45n/nrLeDlmOPRR8jkFp/Zi+ispVdPjA8MYAod+G7/YSjHn9Lpumo27Q+Xsl4q7sJXVetXMu3
	5ztFidCwMaFfLZdyLxFRO5y+PaksdMU29mmlpvE5wh8EiLGDf4Q5yCVXzh9+YPQ44TwxHcU4BDN
	0mSWZIUy5Tf4n3CA1yIjMqVYOvQNJdeoiDMXlvMxcUFC1dt+ORZwZRHRajQchDn1fT4Vq2FnH9+
	Cg45IsPyLYh7QI3NS606cNhej7T2EY38YyMLjkzf0erohSha9JNHbTrJLhTvw0v+QlKG9MKU1ab
	QKsAvm4I5hq+SaN5DGovjoQ==
X-Received: by 2002:a05:6000:610:b0:3ee:109a:3a83 with SMTP id ffacd0b85a97d-40e4ece5726mr16763825f8f.29.1759220826825;
        Tue, 30 Sep 2025 01:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErkmBK2pEHIR11t9h0fOhWc98uNL2Ww5V4K1p5cxBvz0HlJrGFndWMq/zucbPlLC+5Qu2udA==
X-Received: by 2002:a05:6000:610:b0:3ee:109a:3a83 with SMTP id ffacd0b85a97d-40e4ece5726mr16763764f8f.29.1759220826311;
        Tue, 30 Sep 2025 01:27:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603381sm23147503f8f.31.2025.09.30.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:27:05 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:26:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 7/9] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <f7oeyneht4vxtfolrgv36b5tu4zreffcwztimc6s5jixszjt75@yjkhcuhuwbpi>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-7-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-7-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:51PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Improve logging by adding configurable log levels. Additionally, improve
>usability of logging functions. Remove the test name prefix from logging
>functions so that logging calls can be made deeper into the call stack
>without passing down the test name or setting some global. Teach log
>function to accept a LOG_PREFIX variable to avoid unnecessary argument
>shifting.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 75 ++++++++++++++++-----------------
> 1 file changed, 37 insertions(+), 38 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..183647a86c8a 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -51,7 +51,12 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>-VERBOSE=0
>+readonly LOG_LEVEL_DEBUG=0
>+readonly LOG_LEVEL_INFO=1
>+readonly LOG_LEVEL_WARN=2
>+readonly LOG_LEVEL_ERROR=3
>+
>+VERBOSE="${LOG_LEVEL_WARN}"

If the default is 2, how the user can set 3 (error) ?

BTW I find a bit strange the reverse order.
Is this something specific to selftest?

The rest LGTM.

Thanks,
Stefano

>
> usage() {
> 	local name
>@@ -196,7 +201,7 @@ vm_start() {
>
> 	qemu=$(command -v "${QEMU}")
>
>-	if [[ "${VERBOSE}" -eq 1 ]]; then
>+	if [[ ${VERBOSE} -le ${LOG_LEVEL_DEBUG} ]]; then
> 		verbose_opt="--verbose"
> 		logfile=/dev/stdout
> 	fi
>@@ -271,60 +276,56 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>-}
>-
>-__log_stdin() {
>-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
>-}
>
>-__log_args() {
>-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
> }
>
> log() {
>-	local prefix="$1"
>+	local redirect
>+	local prefix
>
>-	shift
>-	local redirect=
>-	if [[ ${VERBOSE} -eq 0 ]]; then
>+	if [[ ${VERBOSE} -gt ${LOG_LEVEL_INFO} ]]; then
> 		redirect=/dev/null
> 	else
> 		redirect=/dev/stdout
> 	fi
>
>+	prefix="${LOG_PREFIX:-}"
>+
> 	if [[ "$#" -eq 0 ]]; then
>-		__log_stdin | tee -a "${LOG}" > ${redirect}
>+		if [[ -n "${prefix}" ]]; then
>+			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
>+		else
>+			cat
>+		fi
> 	else
>-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
>-	fi
>+		if [[ -n "${prefix}" ]]; then
>+			echo "${prefix}: " "$@"
>+		else
>+			echo "$@"
>+		fi
>+	fi | tee -a "${LOG}" > ${redirect}
> }
>
>-log_setup() {
>-	log "setup" "$@"
>+log_host() {
>+	LOG_PREFIX=host log $@
> }
>
>-log_host() {
>-	local testname=$1
>+log_guest() {
>+	LOG_PREFIX=guest log $@
>+}
>
>-	shift
>-	log "test:${testname}:host" "$@"
> }
>
>-log_guest() {
>-	local testname=$1
>
>-	shift
>-	log "test:${testname}:guest" "$@"
> }
>
> test_vm_server_host_client() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${TEST_GUEST_PORT}" \
> 		--peer-cid=2 \
>-		2>&1 | log_guest "${testname}" &
>+		2>&1 | log_guest &
>
> 	vm_wait_for_listener "${TEST_GUEST_PORT}"
>
>@@ -332,18 +333,17 @@ test_vm_server_host_client() {
> 		--mode=client \
> 		--control-host=127.0.0.1 \
> 		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>
> 	return $?
> }
>
> test_vm_client_host_server() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	${VSOCK_TEST} \
> 		--mode "server" \
> 		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>
> 	host_wait_for_listener
>
>@@ -351,19 +351,18 @@ test_vm_client_host_server() {
> 		--mode=client \
> 		--control-host=10.0.2.2 \
> 		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>
> 	return $?
> }
>
> test_vm_loopback() {
>-	local testname="${FUNCNAME[0]#test_}"
> 	local port=60000 # non-forwarded local port
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}" &
>+		--peer-cid=1 2>&1 | log_guest &
>
> 	vm_wait_for_listener "${port}"
>
>@@ -371,7 +370,7 @@ test_vm_loopback() {
> 		--mode=client \
> 		--control-host="127.0.0.1" \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}"
>+		--peer-cid=1 2>&1 | log_guest
>
> 	return $?
> }
>@@ -429,7 +428,7 @@ QEMU="qemu-system-$(uname -m)"
> while getopts :hvsq:b o
> do
> 	case $o in
>-	v) VERBOSE=1;;
>+	v) VERBOSE=$(( VERBOSE - 1 ));;
> 	b) BUILD=1;;
> 	q) QEMU=$OPTARG;;
> 	h|*) usage;;
>@@ -452,10 +451,10 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_setup "Booting up VM"
>+log_host "Booting up VM"
> vm_start
> vm_wait_for_ssh
>-log_setup "VM booted up"
>+log_host "VM booted up"
>
> cnt_pass=0
> cnt_fail=0
>
>-- 
>2.47.3
>


